# Council review record

A separate reviewer applied the seven Council perspectives to the proposal.
These are engineering review lenses, not seven independent human approvals.

Motion: use an isolated two-bone analytical assembly solver, with explicit model
limits, persistent mathematical working and a native 3D projection. Extend the
same model to FK after the request was clarified. Truth proposed the scope and
was recused from the simulated vote; the six remaining lenses and integrator
supported it, subject to implementation tests.

- Architecture: separate solver, projection and GTK UI; preserve existing projects.
- Isolation: no private Bridge source or user data in the public project.
- Field validation: test signals, endpoint coordinates and unreachable targets.
- Language: distinguish inverse kinematics, units, model, branch and singularity.
- Durability: bounded numeric input, clear invalid state and no background work.
- Determinism: independent FK oracle and visible residual, no invented iterations.
- Scope: two rigid bones; do not imply general skeletons or anatomical simulation.

The independent implementation review found a cancellation bug near full folding,
an unstable inner-radius calculation, overly broad singularity wording and weak
UI assertions. Stable half-angle/hypot formulas, precision-specific status and
stronger signal-driven assertions address these. FK-only output validity is now
documented in the public ABI contract. See VERIFICATION.md for evidence limits.
