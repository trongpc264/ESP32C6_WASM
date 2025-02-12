# ESP32_WASM

# WebAssembly Micro Runtime (WAMR)

# Integrate WAMR to ESP-ISF project
This is the default configuration for of ESP-IDF (sdkconfig.h) for WAMR. If you want to change any configuration, go to menuconfig and change the default configuration there.
```
#
# WASM Micro Runtime
#
CONFIG_WAMR_BUILD_RELEASE=y
# CONFIG_WAMR_BUILD_DEBUG is not set
CONFIG_WAMR_ENABLE_AOT=y
CONFIG_WAMR_ENABLE_INTERP=y
# CONFIG_WAMR_INTERP_CLASSIC is not set
CONFIG_WAMR_INTERP_FAST=y
CONFIG_WAMR_INTERP_LOADER_NORMAL=y
# CONFIG_WAMR_INTERP_LOADER_MINI is not set
CONFIG_WAMR_ENABLE_LIB_PTHREAD=y
CONFIG_WAMR_ENABLE_LIBC_BUILTIN=y
CONFIG_WAMR_ENABLE_LIBC_WASI=y
# CONFIG_WAMR_ENABLE_MEMORY_PROFILING is not set
# CONFIG_WAMR_ENABLE_MULTI_MODULE is not set
# CONFIG_WAMR_ENABLE_PERF_PROFILING is not set
# CONFIG_WAMR_ENABLE_REF_TYPES is not set
# CONFIG_WAMR_ENABLE_SHARED_MEMORY is not set
# end of WASM Micro Runtime
# end of Component config
```
If you want to change other configurations, please update the file wasm-micro-runtime/build-scripts/esp-idf/wamr/CMakeLists.txt in WAMR directory.