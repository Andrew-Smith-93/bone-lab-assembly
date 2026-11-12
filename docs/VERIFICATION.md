# Verification

- GCC build of native assembly executable and shared solver: passed.
- Independent Python oracle: 6,144 IK/FK cases, 1,000 camera rotation/projection
  cases, invalid inputs, plus four near-folded/extreme-range regressions passed.
- Geometry tests verify both segment lengths, forward coordinates, closest radial
  residuals, limits, both bend signs and FK→IK endpoint consistency.
- Offscreen GTK fixture with fatal warnings: passed. Real control signals change
  IK/FK modes, target, flexion limits, bend sign and camera. It asserts mode,
  disabled/enabled input groups, yaw propagation, unreachable flag and invalid
  state. It does not substitute direct update calls for those signal changes.
- Offscreen PNGs visually inspected: IK, FK, unreachable and invalid layouts.
- Tests exposed and fixed a wrong widget pointer, SSE mask alignment, pending
  GTK allocation in the fixture, escaped Unicode labels, and near-fold numerical
  cancellation. These are resolved findings, not silently ignored warnings.
- Binary inspected for PIE, RELRO, BIND_NOW, nonexecutable stack and linked system
  dependencies. Public staging and history are scanned before publication.

The tests are synthetic and reproducible. No physical monitor interaction,
screen-reader session, arbitrary skeleton model, GPU renderer, collision physics
or real robot control has been validated. Native controls retain GTK keyboard
and accessibility semantics. UI screenshots use an offscreen GTK window on an
existing authorized display; no visible app was launched by the tests.

Independent re-review closed the numerical/status findings, reran the numerical
suite and isolated install/idempotency/uninstall/conflict tests, and found no
remaining security or public-content blocker under the documented trusted-home
installation model. The independent reviewer had no display access; the primary
agent performed the fatal-warning offscreen UI run and visual inspection.
All 17 staged files were scanned for credential/key patterns, private filesystem
paths, private email addresses and PNG metadata. No findings; publication starts
from a fresh single-commit history. This is a scoped scan, not proof of absence
of every possible secret.
