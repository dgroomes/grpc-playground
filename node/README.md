# node

A working example of client- and server-side JavaScript (Node.js) programs that communicate over gRPC.

This was inspired from the [official gRPC example for Node.js](https://github.com/grpc/grpc/tree/master/examples/node)
but significantly diverges because it uses the `protoc` compiler plugin extension mechanism directly instead of using
the [`grpc-tools` npm module](https://www.npmjs.com/package/grpc-tools) which wraps `protoc`. I would prefer to use
`protoc` directly because it is a common and familiar interface. If I learn `protoc` for a JavaScript project, then I
can use my `protoc` knowledge in a GoLang project, a Java project, or a Python project!

## Instructions

Detailed instructions to build and run the server program and client program. (Note: I developed this project on macOS.)

1. Install Node.js
    * There are a number of ways to do this. I use [nvm](https://github.com/nvm-sh/nvm) to manage my Node.js installations.
1. Install `protoc`. This is the Protocol Buffers compiler.
    * Download it via the Protocol Buffers' [GitHub Releases page](https://github.com/protocolbuffers/protobuf/releases).
      For example, [protoc-3.14.0-osx-x86_64.zip](https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protoc-3.14.0-osx-x86_64.zip)
    * Add it to your `PATH`
1. Install the official `protoc` compiler plugin that supports Node.js/JavaScript code generation
    * Warning: this is complicated! Unfortunately, the plugin artifact is not distributed so we must build it from source
    * What are `protoc` compiler plugins? Read the official documentation page ["Other Languages"](https://developers.google.com/protocol-buffers/docs/reference/other)  
    * Clone the `grpc-node` source code:
       * `git clone https://github.com/grpc/grpc-node.git`
       * `cd grpc-node/`
       * `git submodule sync --recursive`
       * `git -c protocol.version=2 submodule update --init --force --depth=1 --recursive` (what's a more succinct command to pull Git submodules?)
       * Install "cmake" with `brew install cmake`
       * `cd packages/grpc-tools/`
       * Finally, build it with `./build_binaries.sh`
       * The binary should be at the following path underneath the project root: `packages/grpc-tools/build/bin/grpc_node_plugin`
       * Symlink the binary to somewhere on your PATH. For example, this is the command I used on my computer:
          * `ln -s ~/repos/opensource/grpc-node/packages/grpc-tools/build/bin/grpc_node_plugin /usr/local/bin/`            
1. Generate the JavaScript source code from the Protobuf files with: `./generate-protobuf-code.sh`
    * This will have created the files `src/generated/echo_pb.js` and `src/generated/echo_grpc_pb.js`
    * I am choosing to check these files into version control. Alternatively, in your own project, you could gitignore
      the generated code and just build them on-demand as part of your development workflow. That would be the more
      "engineered" approach.
1. Install the project dependencies with `npm install`
1. Run the echo_server with `node src/echo_server.js`. You should see output like this:
   ```
   Listening for requests...
   ```
1. In a new terminal, run the echo_client with `node src/echo_client.js`
   You should see output like this:
   ```
   *Sending* the following message to the server:
   Hello server, I am the client! Nice to meet you!
   
   *Received* the following response from the server:
   Hello server, I am the client! Nice to meet you!...
   Hello server, I am the client! Nice to meet you!...
   Hello server, I am the client! Nice to meet you!...
   ```

## Wish List

General clean ups, TODOs and things I wish to implement for this project:

* Extend the example to something more complex than an echo server. Have a complex type.
* I wish the Node.js/JavaScript `protoc` compiler plugin was distributed so we wouldn't have to build it from source.