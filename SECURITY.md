# Security and provenance

Runtime source is original GNU x86-64 assembly. No private project source,
credentials, accounts, chats, machine configuration or git history was imported.
Only the clean project tree is intended for publication. Screenshots come from
this application's offscreen fixture and contain synthetic numeric inputs.

## Trust boundaries

The app accepts bounded numbers through native GTK spin controls. It has no
application networking, telemetry, subprocess execution, file import/export,
plugin loader, scripting interface, credential access or autostart. GTK and its
system theme/accessibility modules have their normal platform behavior; this is
not an OS sandbox. Distribution library updates remain the user's responsibility.
The test executable alone writes four fixed-name PNG files under `evidence/`.

All formatted mathematical text uses static format strings and GLib allocation.
Solver output is bounded to 200 bytes. Library callers must supply separate,
valid input/output buffers; pointer validation is not part of the C ABI contract.
The GUI uses only process-local static state on the GTK main thread. The solver
is reentrant. Inputs reject nonfinite values and unsupported ranges.

Executable linking enables PIE, full RELRO, immediate binding and nonexecutable
stack. Assembly has no compiler stack-canary instrumentation; memory bounds and
ABI behavior were manually reviewed. This review is not a penetration-test or
memory-safety certification.

## Dependencies

System dependencies: glibc, GTK 3/GDK 3, GLib/GObject, Cairo, GdkPixbuf and libm,
plus their distribution-managed transitive dependencies. No libraries are vendored
or downloaded. The build uses GCC/binutils/make; Python 3 is test/install tooling
and is not embedded in the runtime. No JavaScript or generated C runtime exists.

## Installation

The optional installer reads the locally built ELF and uses its SHA-256 prefix
for a versioned binary directory. It writes only the requested user binary and
two launcher files. It refuses mismatched existing files and symlink paths,
does not request root, launch the app or alter desktop security settings.
Files are installed with ordinary user-owned executable permissions. Review the
local build before installing. Uninstall verifies exact matching contents before
removal. The installer assumes a trusted, single-user home directory; it is not
a defense against a concurrent malicious process running as the same user.
The default desktop path is `~/Desktop`; translated/custom XDG desktop locations
are not auto-detected in this release.

## Reporting

Report non-sensitive issues in the repository issue tracker. Do not post secrets
or exploit details publicly. For sensitive reports, use GitHub private vulnerability
reporting if enabled; otherwise contact the repository owner privately first.
