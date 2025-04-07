#!/bin/bash

# Get the binary path
BIN_PATH=$(swift build --show-bin-path)
PROTOC_GEN_GRPC_PATH="$BIN_PATH/protoc-gen-grpc-swift"
PROTOC_GEN_SWIFT_PATH="$BIN_PATH/protoc-gen-swift"

# Check if protoc-gen-grpc-swift exists
if [ ! -f "$PROTOC_GEN_GRPC_PATH" ]; then
    echo "protoc-gen-grpc-swift not found. Building it now..."
    swift build --product protoc-gen-grpc-swift
fi

rm -r Sources/HelloWorldProto
mkdir -p Sources/HelloWorldProto

protoc \
    --plugin $PROTOC_GEN_GRPC_PATH \
    --grpc-swift_out=Sources/HelloWorldProto \
    --grpc-swift_opt=Visibility=Public \
    --include_imports \
    --descriptor_set_out=Sources/HelloWorldProto/hello_world.protoset \
    --grpc-swift_opt=Server=True \
    --grpc-swift_opt=Client=True \
    -I=Proto \
    Proto/*.proto

# Check if protoc-gen-swift exists
if [ ! -f "$PROTOC_GEN_SWIFT_PATH" ]; then
    echo "protoc-gen-swift not found. Building it now..."
    swift build --product protoc-gen-swift
fi

protoc \
    --plugin $PROTOC_GEN_SWIFT_PATH \
    --swift_out=Sources/HelloWorldProto \
    --swift_opt=Visibility=Public \
    --experimental_allow_proto3_optional \
    -I=Proto \
    Proto/*.proto
