#!/usr/bin/env python3
"""Install/uninstall exact, versioned user files; never run the GUI or network."""
import argparse
import hashlib
from pathlib import Path
import stat

parser = argparse.ArgumentParser()
parser.add_argument('--uninstall', action='store_true')
args = parser.parse_args()
root = Path(__file__).resolve().parent.parent
binary = root / 'build' / 'bone-ik'
blob = binary.read_bytes()
if blob[:4] != b'\x7fELF':
    raise SystemExit('Build the native ELF executable first with make.')
version = hashlib.sha256(blob).hexdigest()[:16]
home = Path.home()
base = home / '.local/lib/bone-lab' / version
exe = base / 'bone-ik'
# Desktop Entry quoting: escape backslash, quote, dollar and backtick; percent is field-code syntax.
quoted = str(exe).replace('\\', '\\\\').replace('"', '\\"').replace('`', '\\`').replace('$', '\\$').replace('%', '%%')
if '\n' in quoted or '\r' in quoted:
    raise SystemExit('Unsupported newline in home directory.')
launcher = ('[Desktop Entry]\nType=Application\nName=Bone Lab — IK + FK\n'
            'Comment=Assembly bone kinematics with 3D geometry and mathematical working\n'
            f'Exec="{quoted}"\nIcon=applications-science\nTerminal=false\n'
            'Categories=Education;Science;Math;\nStartupNotify=false\n').encode()
files = {exe: blob, home / '.local/share/applications/Bone-Lab.desktop': launcher,
         home / 'Desktop/Bone-Lab.desktop': launcher}
for path, content in files.items():
    if path.is_symlink() or any(p.is_symlink() for p in path.parents if p != home.parent):
        raise SystemExit(f'Refusing symbolic link path: {path}')
    if path.exists() and (not path.is_file() or path.read_bytes() != content):
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
        path.chmod(stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR | stat.S_IRGRP | stat.S_IXGRP | stat.S_IROTH | stat.S_IXOTH)
    print(f'Installed Bone Lab version {version}. Desktop launcher ready; app not launched.')
