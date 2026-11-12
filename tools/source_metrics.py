#!/usr/bin/env python3
"""Audit source-line accounting without conflating generated data and logic."""
import argparse
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--write', action='store_true', help='update the public accounting report')
parser.add_argument('--check', action='store_true', help='verify the saved accounting report')
args = parser.parse_args()
files = {}
for path in sorted((ROOT/'src').rglob('*.S')):
    with path.open() as stream:
        files[str(path.relative_to(ROOT))] = sum(1 for _ in stream)
generated = sum(count for name, count in files.items() if name.startswith('src/generated/'))
report = {
    'scope': '.S source lines including comments and blank lines; no Python or Markdown counted',
    'assembly_source_lines': sum(files.values()),
    'generated_assembly_source_lines': generated,
    'non_generated_assembly_source_lines': sum(files.values())-generated,
    'generated_pose_records': 73*61*31,
    'generated_pose_data_directives': 73*61*31*9,
    'generated_pose_data_bytes': 73*61*31*9*8,
    'files': files,
}
text = json.dumps(report, indent=2)+'\n'
output = ROOT/'docs/SOURCE_METRICS.json'
if args.write:
    output.write_text(text)
if args.check and (not output.exists() or output.read_text() != text):
    raise SystemExit('Source accounting differs; run python3 tools/source_metrics.py --write')
print(text, end='')
