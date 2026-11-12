APP_SRC = src/app.S src/math.S src/features.S src/history.S src/atlas.S src/generated/pose_atlas.S src/solver.S src/projection.S
CC = gcc
ASMFLAGS = -O2 -fPIC -Wa,--fatal-warnings
HARDEN = -pie -Wl,-z,relro,-z,now,-z,noexecstack
LIBS = -l:libgtk-3.so.0 -l:libgdk-3.so.0 -l:libgobject-2.0.so.0 -l:libglib-2.0.so.0 -l:libatk-1.0.so.0 -l:libcairo.so.2 -l:libgdk_pixbuf-2.0.so.0 -lm
all: build/bone-ik build/libbone-ik.so
build:
	mkdir -p build
build/libbone-ik.so: src/solver.S src/layout.inc | build
	$(CC) $(ASMFLAGS) -shared -Wl,-z,relro,-z,now,-z,noexecstack -o $@ src/solver.S -lm
build/bone-ik: $(APP_SRC) src/layout.inc | build
	$(CC) $(ASMFLAGS) $(HARDEN) -o $@ $(APP_SRC) $(LIBS)
build/ui-test: $(APP_SRC) src/layout.inc | build
	$(CC) $(ASMFLAGS) $(HARDEN) -DUI_TEST -o $@ $(APP_SRC) $(LIBS)
build/libprojection.so: src/projection.S src/layout.inc | build
	$(CC) $(ASMFLAGS) -shared -o $@ src/projection.S -lm
check: build/libbone-ik.so build/libprojection.so
	python3 tests/numerical.py
	python3 tests/history.py
	python3 tests/atlas.py
	python3 tools/source_metrics.py --check
ui-check: build/ui-test
	G_DEBUG=fatal-warnings ./build/ui-test
.PHONY: all check ui-check

build/ui-narrow: $(APP_SRC) src/layout.inc | build
	$(CC) $(ASMFLAGS) $(HARDEN) -DUI_TEST -DNARROW_TEST -o $@ $(APP_SRC) $(LIBS)
install-check: build/bone-ik
	python3 tests/install.py
.PHONY: install-check

build/libui-fixture.so: $(APP_SRC) src/layout.inc | build
	$(CC) $(ASMFLAGS) -shared -Wl,-Bsymbolic,-z,relro,-z,now,-z,noexecstack -DUI_TEST -o $@ $(APP_SRC) $(LIBS)
pointer-check: build/libui-fixture.so
	G_DEBUG=fatal-warnings python3 tests/pointer.py
.PHONY: pointer-check

features-check: build/libui-fixture.so
	G_DEBUG=fatal-warnings python3 tests/features.py
check-all: all check ui-check pointer-check features-check install-check
.PHONY: features-check check-all
