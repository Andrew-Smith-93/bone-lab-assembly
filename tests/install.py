"""Isolated lifecycle tests: no real home writes and no process launch."""
import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

root = Path(__file__).resolve().parent.parent
blob = (root / 'build/bone-ik').read_bytes()
with tempfile.TemporaryDirectory() as tmp:
    stage = Path(tmp) / 'source'
    home = Path(tmp) / 'home'
    (stage / 'tools').mkdir(parents=True)
    (stage / 'build').mkdir()
    home.mkdir()
    shutil.copy2(root / 'tools/install.py', stage / 'tools/install.py')
    exe = stage / 'build/bone-ik'
    exe.write_bytes(blob)
    env = dict(os.environ, HOME=str(home))
    def run(*args, ok=True):
        result = subprocess.run(['python3', str(stage / 'tools/install.py'), *args], env=env, capture_output=True)
        assert (result.returncode == 0) == ok, result.stderr.decode()
    old = hashlib.sha256(blob).hexdigest()[:16]
    run(); run()
    # ELF permits trailing data. Distinct bytes exercise a version upgrade without running either file.
    newer = blob + b'install-test-version\n'
    new = hashlib.sha256(newer).hexdigest()[:16]
    exe.write_bytes(newer)
    run(ok=False)
    run('--replace-version', old)
    desktop = home / 'Desktop/Bone-Lab.desktop'
    assert new in desktop.read_text()
    assert (home / '.local/lib/bone-lab' / old / 'bone-ik').read_bytes() == blob
    run('--activate-version', old, '--replace-version', new)
    assert old in desktop.read_text()
    run('--replace-version', old)
    run('--uninstall')
    assert not desktop.exists()
    desktop.write_text('unrelated')
    run('--replace-version', old, ok=False)
    assert desktop.read_text() == 'unrelated'
    desktop.unlink()
    desktop.symlink_to(home / 'untouched')
    run(ok=False)
print('PASS: install, idempotency, explicit upgrade, preserved old binary, rollback, uninstall and conflict/symlink refusal')
