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

## Native typeset mathematics

The equation renderer is assembly calling GTK/Pango. Symbolic and substituted
fractions, Greek variables, subscripts/powers, a yaw rotation matrix, componentwise
FK products and vector residuals were visually inspected in full worksheet PNGs.
The law-of-cosines identity is explicitly conditional on an exact unconstrained
solution; the raw target cosine is distinguished from the limited final angle.

The unchanged numerical suite passes. Fatal-warning offscreen fixtures pass at
1320×880 and 1024×820 logical window sizes, plus GTK scale 2. The scale-2 run
checks GTK layout but PNG capture uses logical pixels. Native labels are selectable,
have markup enabled and expose nonempty accessible names; notebook switching and
IK/FK/invalid section visibility are asserted. A screen-reader session, physical
monitor inspection and very large font overrides remain unverified.

Isolated installer tests pass initial/repeat install, explicit upgrade, preservation
of the old binary, version reactivation, uninstall and changed-file/symlink refusal.

## Compact controls and middle-mouse orbit

The updated view is 230 logical pixels tall, with Results below it and grouped
settings beside it. Requested normal/narrow sizes are 1120×760 and 1024×720;
offscreen window captures use GTK's actual allocation (1120×656 and 1024×656).
All pose-summary values and the tab hint fit without scrolling. Full derivations
remain scrollable by design; font size is reduced from 13000 to 11000 Pango units.
The settings sidebar can scroll separately on shorter windows or when Camera is
expanded. A scale-2 GTK layout run passes; captured PNGs use logical pixels.

Passed against the final code:

- The unchanged 6,144 IK/FK cases, 1,000 projection cases and numerical regressions.
- Fatal-warning GTK fixtures at normal, narrow and scale-2 sizes, with actual
  canvas-height assertions, mode-specific field visibility and repeated IK/FK
  switches preserving the retained inputs and computed pose.
- Gesture signals assert button-2 configuration, azimuth wrap, elevation clamp,
  release, cancellation and Reset view. Camera changes leave solver output intact
  and no longer rebuild the mathematical worksheet on each mouse movement.
- Synthetic GDK press/motion/release events delivered through the real offscreen
  GTK canvas verify left-button rejection, held middle-button rotation, movement
  outside canvas bounds, release stopping further rotation and repeated drags.
  This exercises GTK gesture event delivery, not just direct callback invocation.
- Results scroll bounds and compact window bounds, the full plaintext buffer,
  three mathematical tabs, camera reset and clean window/gesture teardown.
- Installer lifecycle, upgrade, preservation of the old binary and rollback.

No physical pointer movement or visible window was used. Physical-monitor input,
OS-level pointer-grab delivery and a screen-reader session remain unverified.
The event test explicitly delivers out-of-bounds coordinates to the widget; it
is not evidence of hardware/OS event delivery outside the application window.
Runtime remains native assembly with the existing system GTK/Cairo dependencies.


Independent review found no blocking security, assembly ABI or mathematical
preservation defect. Its minor gesture-ownership and redundant redraw findings
were corrected, and the final changes were reviewed again. Staged source and
documentation passed scoped credential/private-path scans; PNGs contain no text
or EXIF metadata. PIE, full RELRO, immediate binding and nonexecutable stack remain.
