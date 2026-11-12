#!/usr/bin/env python3
"""Independent native pose-atlas verification; stdlib only.
Pass a shared library path, or compile the two atlas sources in a temporary dir.
"""
import ctypes as C
import math
from pathlib import Path
import random
import struct
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]

class Result(C.Structure):
    _fields_ = [('values', C.c_double * 10), ('count', C.c_uint64)]


def oracle(data):
    x, y, z, l1, l2, lo, hi, branch, yl, yh, pl, ph = data
    best = None
    count = 0
    for yaw in range(-180, 181, 5):
        if not yl <= yaw <= yh:
            continue
        cy, sy = math.cos(math.radians(yaw)), math.sin(math.radians(yaw))
        for stored_pitch in range(-180, 181, 6):
            pitch = stored_pitch * branch
            if not pl <= pitch <= ph:
                continue
            # Calculate directly from actual branch and pitch, not mirrored rows.
            cp, sp = math.cos(math.radians(pitch)), math.sin(math.radians(pitch))
            elbow = (l1 * (cp * cy), l1 * (cp * sy), l1 * sp)
            for flex in range(0, 181, 6):
                if not lo <= flex <= hi:
                    continue
                count += 1
                fore = math.radians(pitch - branch * flex)
                cf, sf = math.cos(fore), math.sin(fore)
                wrist = (elbow[0] + l2 * (cf * cy), elbow[1] + l2 * (cf * sy), elbow[2] + l2 * sf)
                error2 = sum((a - b) ** 2 for a, b in zip(wrist, (x, y, z)))
                if best is None or error2 < best[0]:
                    best = (error2, (yaw, pitch, flex, *elbow, *wrist, math.sqrt(error2)))
    return best, count


def verify_rows():
    values = []
    for line in (ROOT / 'src/generated/pose_atlas.S').open():
        if line.startswith('.double '):
            values.append(float(line[8:]))
    assert len(values) == 1242387
    index = 0
    for yaw in range(-180, 181, 5):
        for pitch in range(-180, 181, 6):
            for flex in range(0, 181, 6):
                row = values[index:index + 9]
                index += 9
                assert row[:3] == [yaw, pitch, flex]
                a, b, f = map(math.radians, (yaw, pitch, pitch - flex))
                expected = (math.cos(b)*math.cos(a), math.cos(b)*math.sin(a), math.sin(b),
                            math.cos(f)*math.cos(a), math.cos(f)*math.sin(a), math.sin(f))
                assert all(abs(got - want) < 2e-15 for got, want in zip(row[3:], expected))
                for vector in (row[3:6], row[6:9]):
                    assert abs(sum(v*v for v in vector) - 1) < 1e-14
    print('All 138043 records independently checked against trigonometry')


def run(library):
    lib = C.CDLL(str(library))
    search = lib.atlas_search
    search.argtypes = [C.POINTER(C.c_double), C.POINTER(Result)]
    search.restype = C.c_int
    def call(data):
        out = Result()
        C.memset(C.byref(out), 0xA5, C.sizeof(out))
        status = search((C.c_double * 12)(*data), C.byref(out))
        return status, out
    base = [1.3, -0.7, 0.8, 1.1, 0.9, 0, 180, 1, -180, 180, -180, 180]
    cases = [base, base[:7] + [-1] + base[8:]]
    rng = random.Random(81273)
    for branch in (1, -1):
        for _ in range(6):
            cases.append([rng.uniform(-3,3) for _ in range(3)] +
                         [rng.uniform(.2,2), rng.uniform(.2,2), 24, 132, branch, -65, 80, -48, 96])
    cases += [[1e6,-1e6,1e6,1e6,.001,0,180,-1,-180,180,-180,180],
              [1,2,3,1,1,42,42,1,15,15,24,24],
              [1,2,3,1,1,42,42,-1,15,15,24,24]]
    for data in cases:
        expected, count = oracle(data)
        status, actual = call(data)
        assert status == 1 and actual.count == count, (status, actual.count, count)
        for got, want in zip(actual.values, expected[1]):
            assert math.isclose(got,want,rel_tol=2e-12,abs_tol=2e-12), (data,list(actual.values),expected)
    # Narrow, valid limits may contain no sample, without implying unreachable.
    for index, low, high in ((8,1,2),(10,1,2),(5,1,2)):
        data = base.copy(); data[index:index+2] = [low,high]
        status, out = call(data)
        assert status == 0 and bytes(out) == bytes(88)
    malformed = []
    for i in range(12):
        for value in (float('nan'),float('inf'),-float('inf'),1000001,-1000001):
            data=base.copy(); data[i]=value; malformed.append(data)
    for i,value in ((3,0),(4,-1),(3,.0009),(5,-1),(6,181),(7,0),(7,.5),(8,-181),(9,181),(10,-181),(11,181)):
        data=base.copy(); data[i]=value; malformed.append(data)
    for lo,hi in ((5,6),(8,9),(10,11)):
        data=base.copy(); data[lo],data[hi]=40,20; malformed.append(data)
    for data in malformed:
        status,out=call(data)
        assert status == -1 and bytes(out) == bytes(88), data
    out=Result(); C.memset(C.byref(out),0xA5,88)
    assert search(None,C.byref(out)) == -1 and bytes(out) == bytes(88)
    assert search((C.c_double*12)(*base),None) == -1
    # Exact repeatability, including first-record tie resolution and output bytes.
    tie=[0,0,0,1,1,180,180,1,-180,180,0,0]
    a=call(tie); b=call(tie)
    assert a[0] == b[0] == 1 and bytes(a[1]) == bytes(b[1])
    print(f'Native atlas search passed {len(cases)} independent oracle cases, {len(malformed)} invalid cases, empty limits, null pointers, determinism')

if __name__ == '__main__':
    subprocess.run([sys.executable,str(ROOT/'tools/generate_atlas.py'),'--check'],check=True)
    verify_rows()
    if len(sys.argv)>1:
        run(Path(sys.argv[1]).resolve())
    else:
        with tempfile.TemporaryDirectory(prefix='bone-atlas-') as tmp:
            path=Path(tmp)/'atlas.so'
            subprocess.run(['gcc','-O2','-fPIC','-shared','-Wl,-z,relro,-z,now,-z,noexecstack',
                            '-Wa,--fatal-warnings','-o',str(path),str(ROOT/'src/atlas.S'),
                            str(ROOT/'src/generated/pose_atlas.S')],check=True)
            run(path)
