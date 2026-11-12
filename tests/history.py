#!/usr/bin/env python3
"""Compile the native history in isolation and verify its public C ABI."""
import ctypes
from pathlib import Path
import random
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SIZE = 128


def snapshot(number):
    return bytes((number * 19 + i * 37) % 256 for i in range(SIZE))


class HistoryTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory(prefix="bone-history-")
        cls.library = Path(cls.temp.name) / "history.so"
        subprocess.run(["cc", "-shared", "-fPIC", "-Wl,-z,noexecstack",
                        str(ROOT / "src/history.S"), "-o", str(cls.library)],
                       check=True)
        cls.lib = ctypes.CDLL(str(cls.library))
        for name in ("reset", "record", "undo", "redo"):
            fn = getattr(cls.lib, "history_" + name)
            fn.argtypes = [ctypes.c_void_p]
            fn.restype = None if name in ("reset", "record") else ctypes.c_int
        for name in ("can_undo", "can_redo"):
            fn = getattr(cls.lib, "history_" + name)
            fn.argtypes = []
            fn.restype = ctypes.c_int

    @classmethod
    def tearDownClass(cls):
        cls.temp.cleanup()

    def setUp(self):
        self.write("reset", snapshot(0))

    def write(self, operation, data):
        # Deliberately unaligned input, with guard bytes on both sides.
        buffer = ctypes.create_string_buffer(b"L" + data + b"R")
        before = buffer.raw
        getattr(self.lib, "history_" + operation)(ctypes.addressof(buffer) + 1)
        self.assertEqual(buffer.raw, before)

    def move(self, operation, expected=None):
        buffer = ctypes.create_string_buffer(b"L" + b"\xa5" * SIZE + b"R")
        before = buffer.raw
        result = getattr(self.lib, "history_" + operation)(ctypes.addressof(buffer) + 1)
        self.assertEqual(result, int(expected is not None))
        if expected is None:
            self.assertEqual(buffer.raw, before)
        else:
            self.assertEqual(buffer.raw[1:129], expected)
            self.assertEqual(buffer.raw[:1], b"L")
            self.assertEqual(buffer.raw[129:], before[129:])

    def flags(self, undo, redo):
        self.assertEqual(self.lib.history_can_undo(), int(undo))
        self.assertEqual(self.lib.history_can_redo(), int(redo))

    def test_reset_and_unavailable_writes(self):
        self.flags(False, False)
        self.move("undo")
        self.move("redo")
        self.write("record", snapshot(1))
        self.write("reset", snapshot(2))
        self.flags(False, False)
        self.move("undo")
        self.move("redo")
        self.write("record", snapshot(3))
        self.move("undo", snapshot(2))
        self.move("redo", snapshot(3))

    def test_duplicate_preserves_redo_and_branch_truncates(self):
        for i in (1, 2):
            self.write("record", snapshot(i))
        self.move("undo", snapshot(1))
        self.write("record", snapshot(1))
        self.flags(True, True)
        self.move("redo", snapshot(2))
        self.move("undo", snapshot(1))
        self.write("record", snapshot(3))
        self.flags(True, False)
        self.move("redo")
        self.move("undo", snapshot(1))
        self.move("undo", snapshot(0))
        self.flags(False, True)

    def test_every_byte_is_compared(self):
        base = bytes(SIZE)
        for index in range(SIZE):
            self.write("reset", base)
            changed = bytearray(base)
            changed[index] = 255
            self.write("record", bytes(changed))
            self.move("undo", base)
            self.move("redo", bytes(changed))

    def test_capacity_and_oldest_retained_snapshot(self):
        for i in range(1, 100):
            self.write("record", snapshot(i))
        self.write("record", snapshot(99))  # No eviction on a duplicate.
        for i in range(98, 35, -1):
            self.move("undo", snapshot(i))
        self.flags(False, True)
        self.move("undo")  # 36 is the oldest retained of 100 snapshots.
        for i in range(37, 100):
            self.move("redo", snapshot(i))
        self.flags(True, False)
        self.move("redo")
        for i in range(98, 35, -1):
            self.move("undo", snapshot(i))
        self.write("record", snapshot(101))  # Branch from oldest slot.
        self.move("undo", snapshot(36))
        self.move("undo")
        self.move("redo", snapshot(101))
        self.move("redo")

    def test_randomized_reference_model(self):
        rng = random.Random(20261112)
        states, cursor = [snapshot(0)], 0
        for _ in range(5000):
            operation = rng.choice(("record", "record", "undo", "redo", "duplicate", "reset"))
            if operation in ("record", "duplicate", "reset"):
                data = states[cursor] if operation == "duplicate" else rng.randbytes(SIZE)
                self.write("record" if operation == "duplicate" else operation, data)
                if operation == "reset":
                    states, cursor = [data], 0
                elif data != states[cursor]:
                    states = (states[:cursor + 1] + [data])[-64:]
                    cursor = len(states) - 1
            elif operation == "undo":
                expected = states[cursor - 1] if cursor > 0 else None
                self.move(operation, expected)
                cursor -= int(expected is not None)
            else:
                expected = states[cursor + 1] if cursor + 1 < len(states) else None
                self.move(operation, expected)
                cursor += int(expected is not None)
            self.flags(cursor > 0, cursor + 1 < len(states))

    def test_zero_initialized_history(self):
        # A fresh process guarantees this test sees pristine .bss storage.
        subprocess.run(["python3", "-c", '''
import ctypes, sys
lib = ctypes.CDLL(sys.argv[1])
for name in ('history_undo', 'history_redo', 'history_record'):
    getattr(lib, name).argtypes = [ctypes.c_void_p]
assert lib.history_can_undo() == lib.history_can_redo() == 0
out = ctypes.create_string_buffer(b'X' * 128)
before = out.raw
assert lib.history_undo(out) == lib.history_redo(out) == 0
assert out.raw == before
lib.history_record(out)
assert lib.history_can_undo() == lib.history_can_redo() == 0
''', str(self.library)], check=True)


if __name__ == "__main__":
    unittest.main(verbosity=2)
