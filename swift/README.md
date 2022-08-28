# swift

A working example of client- and server-side Swift programs that communicate over gRPC.


## Design
 
This project is implemented using the Swift Package Manager (SPM). The client- and server-side programs are their own
SPM *executables* which can be built and run conveniently with the `swift run ...` command.


## Instructions

Follow these instructions to build and run the client- and server-side programs:

1. Use Swift 5.6
2. Install `protoc`. This is the Protocol Buffers compiler.
   * Download it via the Protocol Buffers [GitHub Releases page](https://github.com/protocolbuffers/protobuf/releases).
     For example, [protoc-3.14.0-osx-x86_64.zip](https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protoc-3.14.0-osx-x86_64.zip)
   * Add it to your `PATH`
3. Install the Swift gRPC extension for `protoc`
   * Familiarize yourself with the [README in the official `grpc/grpc-swift` repository](https://github.com/grpc/grpc-swift). 
   * The README describes an option to install from HomeBrew, but for learning purposes I prefer to build from source.
     The following line items describe the rough process I used to build from source and connect the plugins to my `PATH`.
   * Clone the project, check out a proper release branch, run the build, and link the executables.
   * ```shell
     git clone https://github.com/grpc/grpc-swift.git
     ```
   * ```shell
     git checkout 1.8.2
     ```
   * ```shell
     make plugins
     ```
   * ```shell
     ln -s "$PWD/protoc-gen-swift" /usr/local/bin
     ln -s "$PWD/protoc-gen-grpc-swift" /usr/local/bin
     ```
4. Codegen
   * Generate the Swift code from the `.proto`. files. This step is required only if you've updated the `.proto` files.
     I've chosen to version control the generated Swift code. In some projects, you might choose to do code generation
     as a build step and not actually version control the generated code. For learning purposes, I prefer to commit the
     files.
   * ```shell
     ./generate-code.sh
     ```
5. Start the server program
   * ```shell
     swift run Server
     ```
   * It should look like this:
     ```text
     $ swift run Server
     Building for debugging...
     [3/3] Linking Server
     Build complete! (1.13s)
     Started gRPC echo server at [IPv4]127.0.0.1/127.0.0.1:1234
     ```
6. Run the client program
   * ```shell
     swift run Client
     ```
   * It should look like this:
     ```text
     $ swift run Client
     Building for debugging...
     [5/5] Linking Client
     Build complete! (1.11s)
     Got response 'Hello from a client-side Swift program!... Hello from a client-side Swift program!... Hello from a client-side Swift program!'
     ```
7. It worked!
   * You can stop the server process now


## Reference

* [GitHub repo: `grpc-swift`](https://github.com/grpc/grpc-swift)
* [Swift gRPC example](https://github.com/grpc/grpc-swift/tree/main/Sources/Examples/Echo)
  * This is a great "hello world"-style example of gRPC in Swift. 
* [GitHub repo: `apple/swift-protobuf`](https://github.com/apple/swift-protobuf)
