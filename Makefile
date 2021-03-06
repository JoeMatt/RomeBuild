PREFIX?=/usr/local
BUILDPATH?=/tmp/RomeBuild.dst
BUILD_TOOL=swift build
BUILD_TOOL_FLAGS=-c release --build-path "$(BUILDPATH)"
BINARIES_FOLDER=$(PREFIX)/bin

ROME_EXECUTABLE=$(shell $(BUILD_TOOL) $(BUILD_TOOL_FLAGS) --show-bin-path)/romebuild

clean:
	rm -rf "$(BUILDPATH)"

install:
	mkdir -p "$(BUILDPATH)"
	$(BUILD_TOOL) $(BUILD_TOOL_FLAGS)
	mkdir -p "$(BINARIES_FOLDER)"
	cp "$(ROME_EXECUTABLE)" "$(BINARIES_FOLDER)/romebuild"

uninstall:
	rm "$(BINARIES_FOLDER)/romebuild"
