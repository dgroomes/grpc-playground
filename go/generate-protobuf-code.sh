#!/usr/bin/env bash
#
# Generate Go code from the Protobuf definition files (*.proto files)
# TODO how do I set the package to 'rpc'? I just manually edited the package declaration after code generating.

set -eu

dst_dir=rpc

mkdir -p "$dst_dir"

protoc \
  "--go_out=$dst_dir" \
  "--go-grpc_out=$dst_dir" \
  --go_opt=paths=source_relative \
  --go-grpc_opt=paths=source_relative \
  echo.proto
