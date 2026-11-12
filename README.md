# Bone Lab — assembly IK + FK

A native Linux x86-64 calculator for **inverse and forward kinematics**, written
in GNU Intel-syntax assembly. A rotatable orthographic 3D bone view sits beside
the equations, substituted intermediate values, joint coordinates and residual.

The **Typeset mathematics** tab uses native GTK/Pango labels with Greek symbols,
subscripts, superscripts, stacked fractions, vectors and a rotation matrix.
[Full IK worksheet](evidence/typeset-ik.png) · [Full FK worksheet](evidence/typeset-fk.png).
The **Plain-text working** tab retains a linear, selectable transcript. Displayed
decimals are rounded; the solver uses full-precision doubles. The mathematical
font is DejaVu Math TeX Gyre when available, with system font fallback. There is
no browser, TeX subprocess, downloaded font or remote rendering service.

![Inverse kinematics with numerical working](evidence/ik.png)

## Build and launch

Requires GCC/binutils, make, glibc, GTK 3, GDK 3, GLib/GObject, Cairo and libm.
Uses the distribution's installed libraries; no downloads or package installation
happen during build. Python 3 is needed only for tests and optional installation.

```sh
make
make check
./build/bone-ik
```

This release targets Linux x86-64 / System V ABI. It was tested on Debian 13.
It does not support Windows, macOS, ARM, arbitrary skeleton files or hardware
robot control.

## Use

- **IK:** edit target X/Y/Z, bone lengths and elbow limits. The shoulder is at
  the origin. The red ring is the requested target; the dark endpoint is the
  computed wrist. A residual line connects them when the target is unreachable.
- **FK:** check “Forward kinematics,” then edit shoulder yaw, shoulder pitch and
  elbow flexion. Target controls become inactive. Angles directly determine the
  elbow and wrist positions; out-of-limit flexion is rejected, not silently changed.
- **Reverse elbow branch** selects the other bend direction. Switching modes
  uses that mode's retained input values; it does not copy the previous solution.
- Camera azimuth, elevation and zoom change only the view. Keyboard-editable
  native spin controls update the geometry and math immediately. Alt plus the
  underlined label focuses a field. Scroll the math pane to inspect all working.
- The coordinate convention is **Z up**, right-handed world coordinates, arbitrary
  consistent length units. Grid spacing is one unit. Angles in controls are degrees;
  trigonometric calculations use radians. Flexion is 0° straight and 180° folded.
- The projection is orthographic wireframe, without perspective, solid occlusion
  or collision simulation. Large targets/zoom can be outside the viewport; zoom
  out or rotate to inspect them. The math still contains the exact coordinates.

## Mathematical model

Two rigid, zero-thickness bones, unrestricted shoulder yaw and pitch, one elbow
hinge with selectable bend sign `b = ±1`. Elbow constraints are the only joint
limits. The task is endpoint position, not wrist orientation or anatomical motion.

For target `(x,y,z)`, lengths `a,bone2` (called `L1,L2` in the app):

```text
rho = hypot(x,y); r = hypot(rho,z)
yaw = atan2(y,x); beta = atan2(z,rho)
c_raw = (r²-L1²-L2²)/(2 L1 L2)
phi = clamp(acos(clamp(c_raw,-1,1)), min_flexion, max_flexion)
delta = bend_sign * atan2(L2 sin(phi), L1+L2 cos(phi))
pitch = beta + delta
q2 = pitch - bend_sign*phi
E = L1 * (cos(pitch)cos(yaw), cos(pitch)sin(yaw), sin(pitch))
W = E + L2 * (cos(q2)cos(yaw), cos(q2)sin(yaw), sin(q2))
residual = hypot(Wx-x, Wy-y, Wz-z)
```

This is an **analytic evaluation, not an iterative solver**. There is no fictional
convergence graph or iteration count. The full derivation is the law of cosines:
`r² = L1² + L2² + 2 L1 L2 cos(phi)`; isolating `cos(phi)` produces `c_raw`.
The shoulder correction is the angle of vector
`(L1+L2 cos(phi), L2 sin(phi))`. FK applies the last three equations directly.

The admissible radial interval is `[d(max_flexion), d(min_flexion)]`, where
`d(phi)² = L1²+L2²+2 L1 L2 cos(phi)`. The implementation evaluates phi with the algebraically equivalent stable half-angle
formula shown in the app, and computes radial limits with
`hypot(L1-L2, 2 sqrt(L1 L2) cos(phi/2))` to avoid cancellation near folding.
Clamping flexion gives the closest radial
endpoint under this unrestricted-shoulder model. The app verifies the reconstructed
endpoint numerically and says reached only when absolute residual is at most `1e-8`.
A feasible target whose residual exceeds tolerance is labeled a numerical precision
limit rather than unreachable.

At the exact Z axis, IK chooses yaw 0; at the origin, beta 0. At the equal-length
fully folded origin the deterministic branch tends to pitch ±pi/2. These are
nonunique poses. Near-axis (`rho <= 1e-8`) and straight/folded
(`abs(sin(phi)) <= 1e-8`) states are explicitly flagged. Floating-point rounding
can make near-boundary results differ by a few ulps. No temporal continuity or
physical safety guarantees are implied.

Background: [CMU two-link kinematics](https://courses.ideate.cmu.edu/16-375/f2026/text/reference/two-link-kinematics.html).
UI references: [GTK 3 DrawingArea](https://docs.gtk.org/gtk3/class.DrawingArea.html)
and [Pango native text markup](https://docs.gtk.org/Pango/pango_markup.html).
Implementation and illustrations are original; no private Bridge source is included.

## Tests

```sh
make check       # independent Python oracle calls the actual assembly shared objects
make ui-check    # needs an accessible display; offscreen windows only
make install-check  # isolated temporary-home install / upgrade / rollback tests
```

The fixture returns 77 if no display is available. UI tests use native control
signals, IK/FK mode changes, invalid constraints and unreachable targets; PNGs
are written to `evidence/`. They do not launch a visible application window.
See [verification](docs/VERIFICATION.md) and [security](SECURITY.md).

## Optional desktop installation

```sh
python3 tools/install.py
```

Installs the built program and a launcher under your user directories, including
`~/Desktop/Bone-Lab.desktop`. No root access, autostart, network, permissions
relaxation or automatic app launch. Existing different files are refused.
To update an existing install, explicitly name its 16-character version identifier:

```sh
python3 tools/install.py --replace-version OLD_VERSION
# Roll back the launchers without rebuilding or stopping the running application:
python3 tools/install.py --activate-version OLD_VERSION --replace-version NEW_VERSION
```

The identifiers are printed on installation and are the directory names beneath
`~/.local/lib/bone-lab/`. Only exact matching old launchers are replaceable. Previous
binaries remain installed for rollback; an already-running process is untouched.
Each launcher replacement is atomic, but the pair is not a cross-file transaction.
An interrupted update may leave launchers on different versions; rerun the same
command to reconcile them. Uninstall: `python3 tools/install.py --uninstall`
removes only exact files matching the currently built version; it does not remove
older binaries. An empty version directory can remain.

## Assembly API

`ik_solve(input,output)` and `fk_solve(input,output)` return 1 for accepted input,
0 for invalid numeric input (output zeroed). Callers provide separate valid,
nonoverlapping arrays: eight input doubles and 200 output bytes. Null pointers,
overlapping/undersized arrays are outside the ABI contract. See `src/layout.inc`.
Input order is `x,y,z,L1,L2,min,max,branch`; FK replaces x/y/z with yaw/pitch/phi.
Angles are radians; `branch` must be exactly +1 or -1. All numeric magnitudes
must be <=1e6, lengths >=0.001, and `0<=min<=max<=pi`. UI bounds are tighter.
Output slots are documented by named offsets; `FLAGS` is a uint64, not a double:
bit 0 target outside radial limits by more than 1e-8, bit 1 near-axis,
bit 2 near-straight/folded, bit 3 feasible geometry but residual > 1e-8. In FK,
IK-only intermediates (`RAW,C,CP,ELEV,DELTA,NUM`) are not meaningful. The public
routines are reentrant; GTK application state is confined to its main thread.
