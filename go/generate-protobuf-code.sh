#!/usr/bin/env bash
#
# Generate Go code from the Protobuf definition files (*.proto files)

set -eu

dst_dir=rpc

mkdir -p "$dst_dir"

protoc \
  "--go_out=$dst_dir" \
  "--go-grpc_out=$dst_dir" \
  --go_opt=paths=source_relative \
  --go-grpc_opt=paths=source_relative \
  echo.proto
