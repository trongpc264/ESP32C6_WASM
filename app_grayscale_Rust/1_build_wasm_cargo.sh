#!/bin/sh

rm -rf target

echo "Build wasm app .."

export WASI_SDK_PATH=/opt/wasi-sdk/
rustup target add wasm32-wasip1

#rustflags = [
#  "-C", "link-arg=--initial-memory=65536",
#  "-C", "link-arg=-zstack-size=8192",
#  "-C", "link-arg=--export=__heap_base",
#  "-C", "link-arg=--export=__data_end",
#  "-C", "link-arg=--strip-all",
#]
#
cargo build --release --target wasm32-wasip1
cp -f target/wasm32-wasip1/release/grayscale.wasm ./

#
#rustc   -C link-self-contained=no \
#        -C link-arg=--initial-memory=65536 \
#        -C link-args=-zstack-size=8192 \
#        -C link-args=--no-entry \
#        --target wasm32-wasip1 src/main.rs
#mv main.wasm grayscale.wasm

echo "Generate grayscale_rust.h .."
../tools/binarydump-tool/build/binarydump \
        -o grayscale_rust.h \
        -n wasm_grayscale_file \
           grayscale.wasm

echo "Done"

