# node

A working example of client- and server-side JavaScript (Node.js) programs that communicate over gRPC.

This was inspired from the [official gRPC example for Node.js](https://github.com/grpc/grpc/tree/master/examples/node)
but significantly diverges because it uses the `protoc` compiler plugin extension mechanism directly instead of using
the [`grpc-tools` npm module](https://www.npmjs.com/package/grpc-tools) which distributes a customized `protoc` that
supports JS. I would prefer to use the official `protoc` command instead of a customized one and I would prefer to use
it directly instead of behind a wrapping abstraction. `protoc` is a common and familiar interface. If I have already
learned `protoc` in the context of Go, Java or Swift projects then I want to continue to use my `protoc` knowledge when
I move into a JavaScript, Python or Rust project. Learn once, use everywhere.


## Instructions

Detailed instructions to build and run the server program and client program. (Note: I developed this project on macOS
and using the WebStorm JavaScript IDE).

1. Install Node.js
    * There are a number of ways to do this. I use [Fast Node Manager (`fnm`)](https://github.com/Schniz/fnm) to manage my Node.js installations.
    * I used Node v20.10.0
2. Install `protoc`. This is the Protocol Buffers compiler.
    * Download it via the Protocol Buffers [GitHub Releases page](https://github.com/protocolbuffers/protobuf/releases).
      For example, [protoc-23.2-osx-aarch_64.zip](https://github.com/protocolbuffers/protobuf/releases/download/v23.2/protoc-23.2-osx-aarch_64.zip)
    * Unzip it and then remove the quarantine bit on the `protoc` binary with a command like the following.
    * ```shell
       sudo xattr -d com.apple.quarantine bin/protoc
       ```
    * Add it to your `PATH`
3. Install the JavaScript `protoc` compiler plugin
    * Note: What are `protoc` compiler plugins? Read the official documentation page ["Other Languages"](https://developers.google.com/protocol-buffers/docs/reference/other)  
    * From the [protocolbuffers/protobuf-javascript](https://github.com/protocolbuffers/protobuf-javascript) repository,
      download the latest release appropriate for your system architecture. For me, this was [protobuf-javascript-3.21.2-osx-aarch_64.tar.gz](https://github.com/protocolbuffers/protobuf-javascript/releases/download/v3.21.2/protobuf-javascript-3.21.2-osx-aarch_64.tar.gz).
    * Unzip the file, remove the quarantine bit on the `protoc-gen-js` binary, and move the binary to your `PATH`. I used the
      following commands.
    * ```shell
      cd ~/Downloads
      tar -xvf protobuf-javascript-3.21.2-osx-aarch_64.tar.gz
      sudo xattr -d com.apple.quarantine bin/protoc-gen-js
      sudo mv bin/protoc-gen-js /usr/local/bin/
      ```
4. Install the gRPC for Node.js `protoc` compiler plugin
    * Warning: this is complicated! Unfortunately, the plugin artifact is not distributed, so we must build it from
      source.
    * Clone the `grpc-node` source code with the following commands.
    * ```shell
      git clone https://github.com/grpc/grpc-node.git
      cd grpc-node/
      git submodule sync --recursive
      git -c protocol.version=2 submodule update --init --force --depth=1 --recursive
      ```
    * (Note: what's a more succinct command to pull Git submodule
    * Install "cmake" with the following command.
    * ```shell
      brew install cmake
      ```
    * Build the project with the following commands.
    * ```shell
      cd packages/grpc-tools/
      ./build_binaries.sh
      ```
    * The binary should be at the following path underneath the project root: `packages/grpc-tools/build/bin/grpc_node_plugin`
    * Symlink the binary to somewhere on your PATH. For example, the following is the command I used on my computer.
    * ```shell
      ln -s ~/repos/opensource/grpc-node/packages/grpc-tools/build/bin/grpc_node_plugin /usr/local/bin/
      ```            
5. Generate the JavaScript source code from the Protobuf files
    * ```shell
      ./generate-protobuf-code.sh
      ```
    * This will have created the files `src/generated/echo_pb.js` and `src/generated/echo_grpc_pb.js`
    * I am choosing to check these files into version control. Alternatively, in your own project, you could gitignore
      the generated code and just build them on-demand as part of your development workflow. That would be the more
      "engineered" approach.
6. Install the project dependencies 
    * ```shell
      npm install
      ```
7. Run the echo_server:
    * ```shell
      node src/echo_server.js
      ```
    * You should see output like the following.
    * ```text
      Listening for requests...
      ```
8. In a new terminal, run the echo_client
    * ```shell
      node src/echo_client.js
      ```
    * You should see output like the following.
    * ```text
      *Sending* the following message to the server:
      Hello server, I am the client! Nice to meet you!
      
      *Received* the following response from the server:
      Hello server, I am the client! Nice to meet you!...
      Hello server, I am the client! Nice to meet you!...
      Hello server, I am the client! Nice to meet you!...
      ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [ ] Extend the example to something more complex than an echo server. Have a complex type.
* [ ] I wish the Node.js/JavaScript `protoc` compiler plugin was distributed, so we wouldn't have to build it from source.
  Keep an eye on it.
