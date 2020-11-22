#!/usr/bin/env bash
#
# Generate JavaScript code from the Protobuf definition files (*.proto files)
#
# For some reason, the "grpc_node_plugin" must be referenced by its absolute path so we use `which` to find the
# absolute path. See https://github.com/grpc/grpc/issues/7650#issuecomment-237894061
#
# The "grpc_js" option is given to "--grpc_out" so that the generated code depends on "grpc-js" instead of "grpc".
# "grpc-js" is the replacement for "grpc". See the announcement blog post https://grpc.io/blog/grpc-js-1.0/

dst_dir=src/generated

protoc \
  --plugin=protoc-gen-grpc=$(which grpc_node_plugin) \
  "--js_out=import_style=commonjs,binary:$dst_dir" \
  "--grpc_out=grpc_js:$dst_dir" \
  echo.proto