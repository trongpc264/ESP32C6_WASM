#!/bin/sh

rm -rf target

export WASI_SDK_PATH=/opt/wasi-sdk/
rustup target add wasm32-wasip1

# Config in Cargo.toml
#rustflags = [
#  "-C", "link-arg=--initial-memory=65536",
#  "-C", "link-arg=-zstack-size=8192",
#  "-C", "link-arg=--export=__heap_base",
#  "-C", "link-arg=--export=__data_end",
#  "-C", "link-arg=--strip-all",
#]
#

echo "Build wasm app from cargo build .."
echo "Generate helloworld.wasm .."
cargo build --release --target wasm32-wasip1

#
#rustc   -C link-self-contained=no \
#        -C link-arg=--initial-memory=65536 \
#        -C link-args=-zstack-size=8192 \
#        -C link-args=--export=__heap_base \
#        -C link-args=--export=__data_end \
#        -C link-args=--no-entry \
#        --target wasm32-wasip1 src/main.rs
#mv main.wasm helloworld.wasm

echo "Generate wasm_grayscale_rust.h .."
../tools/binarydump-tool/build/binarydump \
        -o wasm_helloworld_rust.h \
        -n wasm_application_file \
           target/wasm32-wasip1/release/helloworld.wasm

echo "Done"
