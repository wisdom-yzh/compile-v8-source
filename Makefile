CC := g++
PATH := $(PWD)/depot_tools:$(PATH)

v8:
	if [ ! -d "./v8" ]; then \
		env PATH=$(PATH) && fetch v8; \
	fi;
	cd v8 && env PATH=$(PATH) && gclient sync
	if [ "$(uname)" = "Linux" ]; then \
		cd v8 && build/install-build-deps.sh; \
	fi;
	cd v8 && ./tools/dev/v8gen.py x64.release -- v8_monolithic=true v8_use_external_startup_data=false use_custom_libcxx=false
	depot_tools/ninja -C v8/out.gn/x64.release v8_monolith
