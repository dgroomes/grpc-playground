# grpc-playground

📚 Learning and exploring gRPC.

> A high-performance, open source universal RPC framework
>
> -- <cite>https://grpc.io/</cite>


## Standalone subprojects

This repository illustrates different concepts, patterns and examples via standalone subprojects. Each subproject is
completely independent of the others and do not depend on the root project. This _standalone subproject constraint_
forces the subprojects to be complete and maximizes the reader's chances of successfully running, understanding, and
re-using the code.

The subprojects include:

### `node/`

A working example of client- and server-side JavaScript (Node.js) programs that communicate over gRPC.

See the README in [node/](node/).

### `java/`

A working example of client- and server-side Java programs that communicate over gRPC.

See the README in [java/](java/).

### `go/`

A working example of client- and server-side Go programs that communicate over gRPC.

See the README in [go/](go/).

### `swift/`

A working example of client- and server-side Swift programs that communicate over gRPC.

See the README in [swift/](swift/).


## Protobuf: Impressions

Protobuf is well-maintained and feature-rich. One thing that often confuses me, especially because I become newly
acquainted with Protobuf every year or so, is the [versioning strategy](https://protobuf.dev/support/version-support/).
Read the docs!


## Reference

* [Protobuf official site](https://developers.google.com/protocol-buffers)
* [Protobuf official site: Language Guide for "proto3"](https://developers.google.com/protocol-buffers/docs/proto3)
* [Protobuf GitHub repo: JavaScript support](https://github.com/protocolbuffers/protobuf/tree/master/js)
* [Protobuf official site: Other Languages](https://developers.google.com/protocol-buffers/docs/reference/other)
* [gRPC official site: Quick start for Node.js/JavaScript](https://grpc.io/docs/languages/node/quickstart/)
  * Unfortunately, the Node.js/JavaScript implementation does not include instructions on using the plugin mechanism of
    `protoc` to generate gRPC JavaScript code from `*.proto` files. By contrast, the GoLang implementation does have
    instructions so I used the GoLang instructions as a working example to figure out how to do the JavaScript one.
* [gRPC official site: Quick start for GoLang](https://grpc.io/docs/languages/go/quickstart/)
* [gRPC GitHub issues: a comment indicating how to use the gRPC Node plugin with protoc](https://github.com/grpc/grpc/issues/7650#issuecomment-237894061)
* [gRPC official site: Quick start for Go](https://grpc.io/docs/languages/go/)
