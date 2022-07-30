# go

A working example of client- and server-side Go programs that communicate over gRPC.

This was inspired from
the [official "helloworld" gRPC example for Go](https://github.com/grpc/grpc-go/tree/master/examples).


## Instructions

Follow these instructions to do the Protobuf code gen, and build and run a server program and client program.

1. Install `protoc`. This is the Protocol Buffers compiler.
    * Download it via the Protocol Buffers [GitHub Releases page](https://github.com/protocolbuffers/protobuf/releases).
      For example, [protoc-3.14.0-osx-x86_64.zip](https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protoc-3.14.0-osx-x86_64.zip)
    * Add it to your `PATH`
2. Install the Go gRPC extension for `protoc`
    * Pre-compiled binaries are available to download. Follow the note in the [gRPC Go Quick Start](https://grpc.io/docs/languages/go/quickstart/):
      > Install the protocol compiler plugins for Go using the following commands:
      >
      > ```
      > go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26
      > go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1
      > ```
    * Just like any Go binary you install with `go install`, these binaries will be in the `bin/` directory of your Go
      workspace. By convention, the workspace is usually described by the environment variable `GOPATH`. Make sure the
      `GOPATH` is on your `PATH`.
3. Generate the Go source code from the Protobuf files:
    * ```shell
      ./generate-protobuf-code.sh
      ```
    * This will have created the files `src/echo.pb.go` and `src/echo_grpc.pb.go`.
    * I am choosing to check these files into version control. Alternatively, in your own project, you could ignore the
      files using the `.gitignore` file and instead run the code generation on-demand as part of your development
      workflow. That might be considered a more "engineered" approach.
4. Build and run a gRPC server program:
    * ```shell
      go run cmd/server/echo_server_main.go
      ```
    * It should look like this
      ```text
      $ go run cmd/server/echo_server_main.go
      2022/07/30 09:13:01 Echo server listening at [::]:50051
      ```
5. Build and run a gRPC client program:
    * ```shell
      go run cmd/client/echo_client_main.go "Hello there"
      ```
    * It should look like this
      ```text
      $ go run cmd/client/echo_client_main.go "Hello there"
      2022/07/30 09:13:19 Sending message:  Hello there
      2022/07/30 09:13:19 Received response:
      Hello there...
      Hello there...
      Hello there...
      ```


## Notes

I'm still very early on my Go learning. I don't understand the generated code. There are some peculiarities. It looks
like there is a lot of explanation in this [GH issue discussion](https://github.com/grpc/grpc-go/issues/3794). 
