# Constrained native pose atlas

Bone Lab's atlas is a generated numerical data set consumed by the native
`atlas_search` assembly routine. It is **not 1.2 million lines of handwritten
algorithmic assembly**. The generated `.double` directives are meaningful
assembly source data, not filler instructions, comments, repeated padding, or
unreferenced labels. Every record is traversed during a full-limit search.

## Exact accounting

- 73 shoulder-yaw samples: −180° through +180°, spacing 5°.
- 61 shoulder-pitch samples: −180° through +180°, spacing 6°.
- 31 elbow-flexion samples: 0° through 180°, spacing 6°.
- 73 × 61 × 31 = **138,043 pose records**.
- Nine `.double` directives per record = **1,242,387 assembly data lines**.
- Nine eight-byte doubles per record = **9,939,096 binary data bytes**,
  excluding alignment and the executable's other sections.

The nine fields are yaw degrees, pitch degrees, flexion degrees, upper-arm
unit X/Y/Z, and forearm unit X/Y/Z. Upper-arm elevation is pitch; positive-bend
forearm elevation is pitch minus flexion. The records are ordered yaw, then
pitch, then flexion, in increasing sample order. The ±180° endpoints remain
explicit samples so both closed-limit boundary values are available; these
represent equivalent orientations but distinct boundary angle values.

`src/generated/pose_atlas.S` places the data in read-only storage. Its start
and end symbols are global hidden symbols, permitting linked native code to
reference the table without exporting writable state. `src/atlas.S` performs
the actual bounded search. No network access or downloaded data is involved.

## Reproduction and checks

Run from the repository root:

```
python3 tools/generate_atlas.py
python3 tools/generate_atlas.py --check
python3 tests/atlas.py
```

The generator uses Python's standard math library and seventeen significant
digits to round-trip every double. `--check` compares exact source contents;
standard library/libm changes on other platforms can produce last-bit changes
and therefore correctly fail that byte-for-byte check. Tests verify every row
against independent trigonometry, normalized direction vectors, independent
nearest-pose oracles, both bend branches, malformed input, empty sample ranges,
null pointers, and deterministic repeated outputs. By default the test compiles
only the two atlas sources into a temporary shared library. An optional path
argument tests an existing shared library instead.

## Native ABI

SysV AMD64: `int atlas_search(const double input[12], void *output88)`.
Input and output buffers must be valid, appropriately sized, and nonoverlapping.
The output buffer consists of ten doubles followed by one uint64 (88 bytes).

Input doubles:

1. target X, Y, Z
2. upper-arm length, forearm length
3. minimum flexion degrees, maximum flexion degrees
4. branch: exactly +1 or −1
5. minimum yaw degrees, maximum yaw degrees
6. minimum pitch degrees, maximum pitch degrees

The wording above groups related fields; the actual input has twelve doubles.
All values must be finite. Target coordinates must have magnitude at most
1,000,000. Lengths must be between 0.001 and 1,000,000, inclusive. Flexion bounds
must be ordered within [0,180]. Yaw and pitch bounds must be ordered within
[−180,180]. Bounds do not wrap around ±180; split a wrapping interval yourself.

Output offsets:

- 0, 8, 16: selected yaw, pitch, flexion in degrees.
- 24, 32, 40: elbow X/Y/Z.
- 48, 56, 64: wrist X/Y/Z.
- 72: Euclidean wrist-to-target error.
- 80: uint64 count of candidates satisfying all supplied angular bounds.

Return value 1 means a nearest sampled candidate was found; 0 means no atlas
sample satisfies the bounds; −1 means invalid input. Output is zeroed on
failure. A null output pointer returns −1 without writing; a null input pointer
returns −1 after zeroing a non-null output. Arbitrary invalid memory pointers
are not safe inputs, as with any C ABI.

Negative branch reuses each positive-bend record by negating its stored pitch
and both direction vectors' Z components, keeping X/Y unchanged. Bounds are
checked against that actual, mirrored pitch. This yields forearm elevation
`actual_pitch + flexion`. The scan selects the smallest squared Cartesian
error; exact floating-point ties retain the first record in storage order.
Search is allocation-free and reentrant, with no mutable global state.

## Honest limits

This is the **nearest sampled pose**, not a globally optimal solution to
continuous constrained inverse kinematics. The visible grid resolution is
5° yaw / 6° pitch / 6° flexion. Narrow valid intervals may contain no samples.
An empty result does not prove physical unreachability. Nearby continuous
poses, including exact solutions, can lie between samples. Floating-point
roundoff affects near-ties. Performance is linear in 138,043 records and should
be measured on the deployment machine rather than described as constant-time.

The analytic solver remains separate. The application must link the two atlas
sources and explicitly call `atlas_search` for its constrained-search mode;
merely linking the data without calling the routine is not runtime use.
