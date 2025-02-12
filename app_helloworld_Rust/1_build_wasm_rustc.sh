#!/bin/sh

export WASI_SDK_PATH=/opt/wasi-sdk/
rustup target add wasm32-wasip1

#rm -rf target

#rustflags = [
#  "-C", "link-arg=--initial-memory=65536",
#  "-C", "link-arg=-zstack-size=8192",
#  "-C", "link-arg=--export=__heap_base",
#  "-C", "link-arg=--export=__data_end",
#  "-C", "link-arg=--strip-all",
#]

#cargo build --release --target wasm32-wasip1

echo "Build wasm app from rusct .."
rustc   -C link-self-contained=no \
        -C link-arg=--initial-memory=65536 \
        -C link-args=-zstack-size=8192 \
        -C link-args=--export=__heap_base \
        -C link-args=--export=__data_end \
        -C link-args=--no-entry \
        --target wasm32-wasip1 src/main.rs
mv main.wasm helloworld.wasm

echo "Generate wasm_grayscale_rust.h .."
../tools/binarydump-tool/build/binarydump \
        -o wasm_helloworld_rust.h \
        -n wasm_application_file \
           helloworld.wasm

echo "Done"
