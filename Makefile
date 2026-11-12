CC = gcc
ASMFLAGS = -O2 -fPIC -Wa,--fatal-warnings
HARDEN = -pie -Wl,-z,relro,-z,now,-z,noexecstack
LIBS = -l:libgtk-3.so.0 -l:libgdk-3.so.0 -l:libgobject-2.0.so.0 -l:libglib-2.0.so.0 -l:libcairo.so.2 -l:libgdk_pixbuf-2.0.so.0 -lm
all: build/bone-ik build/libbone-ik.so
build:
	mkdir -p build
build/libbone-ik.so: src/solver.S src/layout.inc | build
	$(CC) $(ASMFLAGS) -shared -Wl,-z,relro,-z,now,-z,noexecstack -o $@ src/solver.S -lm
build/bone-ik: src/app.S src/solver.S src/projection.S src/layout.inc | build
	$(CC) $(ASMFLAGS) $(HARDEN) -o $@ src/app.S src/solver.S src/projection.S $(LIBS)
build/ui-test: src/app.S src/solver.S src/projection.S src/layout.inc | build
	$(CC) $(ASMFLAGS) $(HARDEN) -DUI_TEST -o $@ src/app.S src/solver.S src/projection.S $(LIBS)
build/libprojection.so: src/projection.S src/layout.inc | build
	$(CC) $(ASMFLAGS) -shared -o $@ src/projection.S -lm
check: build/libbone-ik.so build/libprojection.so
	python3 tests/numerical.py
ui-check: build/ui-test
	G_DEBUG=fatal-warnings ./build/ui-test
.PHONY: all check ui-check
