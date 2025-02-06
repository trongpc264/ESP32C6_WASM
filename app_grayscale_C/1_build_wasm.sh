# Copyright (C) 2019 Intel Corporation.  All rights reserved.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

echo "Build wasm app .."

# Normal build
/opt/wasi-sdk/bin/clang -O3 \
-o grayscale_normal.wasm src/grayscale.c

# Optimize build
#       '-O3' to enable only conforming optimizations
#       -nostdlib: Do not use the standard system startup files or libraries when linking
#                  => libc-builtin should be enabled in runtime using cmake -DWAMR_BUILD_LIBC_BUILT=1
#       -z stack-size=<vlaue>   The auxiliary stack size, which is an area of linear memory, 
#                               must be smaller than the initial memory size.
#       -Wl,--initial-memory=<value> Initial size of the linear memory, which must be a multiple of 65536
#       -Wl,--max-memory=<value> Maximum size of the linear memory, which must be a multiple of 65536
#       -Wl,--export=<value> Force the <value> symbol to be exported
#       -Wl,--no-entry Do not output any entry point
#       -Wl,--strip-all Strip all symbols

/opt/wasi-sdk/bin/clang -O3 -nostdlib \
        -z stack-size=4096 -Wl,--initial-memory=65536 \
        -o grayscale.wasm src/grayscale.c \
        -Wl,--export=main -Wl,--export=__main_argc_argv \
        -Wl,--export=__data_end -Wl,--export=__heap_base \
        -Wl,--strip-all,--no-entry \
        -Wl,--allow-undefined
         

echo "Generate grayscale_c.h .."
../tools/binarydump-tool/build/binarydump \
        -o grayscale_c.h \
        -n wasm_grayscale_file \
           grayscale.wasm

echo "Done"
