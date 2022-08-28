#!/usr/bin/env bash
#
# Generate Swift code from the Protobuf definition files (*.proto files)

set -eu

server_dst_dir=Sources/Server
client_dst_dir=Sources/Client

# Generate server code
protoc \
  "--swift_out=Visibility=Public:$server_dst_dir" \
  "--grpc-swift_out=Visibility=Public,Client=false,Server=true:$server_dst_dir" \
  echo.proto

# Generate client code
protoc \
  "--swift_out=Visibility=Public:$client_dst_dir" \
  "--grpc-swift_out=Visibility=Public,Client=true,Server=false:$client_dst_dir" \
  echo.proto
