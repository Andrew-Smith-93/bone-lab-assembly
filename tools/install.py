#!/usr/bin/env python3
"""Install/uninstall exact, versioned user files; never run the GUI or network."""
import argparse
import hashlib
from pathlib import Path
import stat
import re
import os
import tempfile

parser = argparse.ArgumentParser()
parser.add_argument('--uninstall', action='store_true')
parser.add_argument('--replace-version', help='Exact installed version whose matching launchers may be replaced; its binary is preserved')
parser.add_argument('--activate-version', help='Reactivate an already installed version (use with --replace-version for rollback)')
args = parser.parse_args()
root = Path(__file__).resolve().parent.parent
binary = root / 'build' / 'bone-ik'
home = Path.home()
for value in (args.replace_version, args.activate_version):
    if value is not None and not re.fullmatch(r'[0-9a-f]{16}', value):
        raise SystemExit('Version identifiers must be 16 lowercase hexadecimal characters.')
if args.uninstall and (args.replace_version or args.activate_version):
    raise SystemExit('Uninstall cannot be combined with activation or replacement.')
if args.activate_version:
    binary = home / '.local/lib/bone-lab' / args.activate_version / 'bone-ik'
    if binary.is_symlink():
        raise SystemExit('Refusing symbolic-link binary.')
blob = binary.read_bytes()
if blob[:4] != b'\x7fELF':
    raise SystemExit('Build the native ELF executable first with make.')
version = hashlib.sha256(blob).hexdigest()[:16]
if args.activate_version and version != args.activate_version:
    raise SystemExit('Installed binary content does not match its version.')
base = home / '.local/lib/bone-lab' / version
exe = base / 'bone-ik'

def launcher_for(version):
    target = home / '.local/lib/bone-lab' / version / 'bone-ik'
    quoted = str(target).replace('\\', '\\\\').replace('"', '\\"').replace('`', '\\`').replace('$', '\\$').replace('%', '%%')
    if '\n' in quoted or '\r' in quoted:
        raise SystemExit('Unsupported newline in home directory.')
    return ('[Desktop Entry]\nType=Application\nName=Bone Lab — IK + FK\n'
            'Comment=Assembly bone kinematics with 3D geometry and mathematical working\n'
            f'Exec="{quoted}"\nIcon=applications-science\nTerminal=false\n'
            'Categories=Education;Science;Math;\nStartupNotify=false\n').encode()

launcher = launcher_for(version)
previous = launcher_for(args.replace_version) if args.replace_version else None
files = {exe: blob, home / '.local/share/applications/Bone-Lab.desktop': launcher,
         home / 'Desktop/Bone-Lab.desktop': launcher}
for path, content in files.items():
    if path.is_symlink() or any(p.is_symlink() for p in path.parents if p != home.parent):
        raise SystemExit(f'Refusing symbolic link path: {path}')
    if path.exists() and (not path.is_file() or (path.read_bytes() != content and not (path != exe and previous is not None and path.read_bytes() == previous))):
        raise SystemExit(f'Refusing changed or unrelated file: {path}')
if args.uninstall:
    for path in files:
        if path.exists():
            path.unlink()
    print('Removed matching Bone Lab binary and launchers. Source and other files preserved.')
else:
    for path, content in files.items():
        path.parent.mkdir(parents=True, exist_ok=True)
        if not path.exists():
            # Exclusive creation avoids replacing a file created since preflight.
            with path.open('xb') as stream:
                stream.write(content)
        elif path.read_bytes() != content:
            # Only the exact launcher authorized by --replace-version can reach here.
            # Atomic per file; never touch the previous executable or running process.
            if path.read_bytes() != previous:
                raise SystemExit(f'Launcher changed during update: {path}')
            with tempfile.NamedTemporaryFile(dir=path.parent, prefix='.bone-lab-', delete=False) as stream:
                staged = Path(stream.name)
                try:
                    stream.write(content)
                    stream.flush()
                    os.fsync(stream.fileno())
                except BaseException:
                    staged.unlink(missing_ok=True)
                    raise
            try:
                staged.chmod(0o755)
                os.replace(staged, path)
            finally:
                staged.unlink(missing_ok=True)
        path.chmod(stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR | stat.S_IRGRP | stat.S_IXGRP | stat.S_IROTH | stat.S_IXOTH)
    print(f'Installed Bone Lab version {version}. Desktop launcher ready; app not launched.')
