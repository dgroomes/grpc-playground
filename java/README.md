# java

A working example of client- and server-side Java programs that communicate over gRPC.

This was inspired from the [official "helloworld" gRPC example for Java](https://github.com/grpc/grpc-java/tree/master/examples)
but significantly diverges because it uses the `protoc` compiler plugin extension mechanism directly instead of using
it via a Gradle plugin which wraps `protoc`. I would prefer to use `protoc` directly because it is a common and familiar
interface. If I learn `protoc` for a Java project, then I can use my `protoc` knowledge in a GoLang project, a
JavaScript project, or a Python project!

## Instructions

Detailed instructions to build and run the server program and client program. (Note: I developed this project on macOS
and using Intellij).

1. Install Java 17
    * I use [SDKMAN](https://sdkman.io/) to manage my installations of Java
1. Install `protoc`. This is the Protocol Buffers compiler.
    * Download it via the Protocol Buffers [GitHub Releases page](https://github.com/protocolbuffers/protobuf/releases).
      For example, [protoc-3.14.0-osx-x86_64.zip](https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protoc-3.14.0-osx-x86_64.zip)
    * Add it to your `PATH`
1. Install the Java gRPC extension for `protoc`
    * Follow the note in [`grpc-java`'s README for the compiler](https://github.com/grpc/grpc-java/tree/master/compiler):
      > Normally you don't need to compile the codegen by yourself, since pre-compiled binaries for common platforms are available on Maven Central:
      >  
      > 1. Navigate to https://mvnrepository.com/artifact/io.grpc/protoc-gen-grpc-java
      > 1. Click into a version
      > 1. Click "Files"
    * For example, [protoc-gen-grpc-java-1.33.1-osx-x86_64.exe](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.33.1/protoc-gen-grpc-java-1.33.1-osx-x86_64.exe)
    * Make it executable, move it somewhere on your PATH, and rename it to *exactly* `protoc-gen-java-grpc`. For example
      I executed these commands on my computer:
      ```
      mv ~/Downloads/protoc-gen-grpc-java-1.33.1-osx-x86_64.exe /usr/local/bin/protoc-gen-java-grpc
      chmod +x /usr/local/bin/protoc-gen-java-grpc
      ```
1. Generate the Java source code from the Protobuf files
    * Move into the `rpc/` sub-project: `cd rpc`
    * Generate the Java source with: `./generate-protobuf-code.sh`
    * This will have created the files `src/main/java/dgroomes/EchoProtos.java` and `src/main/java/dgroomes/EchoGrpc.java`
    * I am choosing to check these files into version control. Alternatively, in your own project, you could gitignore
      the generated code and just build them on-demand as part of your development workflow. That would be the more
      "engineered" approach.
    * Return to the root of the sub-project: `cd ..` 
1. Build the project with `./gradlew installDist` 
1. Run the echo_server with `server/build/install/server/bin/server`. You should see output like this:
   ```
   Nov 23, 2020 10:05:32 PM dgroomes.ServerMain main
   INFO: Listening for requests...
   ```
1. In a new terminal, run the echo_client with `client/build/install/client/bin/client`
   You should see output like this:
   ```
   Nov 23, 2020 10:29:19 PM dgroomes.ClientMain sendRequest
   INFO: *Sending* the following message to the server:
   Hello server, I am a Java-based client! Nice to meet you!
   
   Nov 23, 2020 10:29:20 PM dgroomes.ClientMain sendRequest
   INFO: *Received* the following response from the server:
   Hello server, I am a Java-based client! Nice to meet you!...
   Hello server, I am a Java-based client! Nice to meet you!...
   Hello server, I am a Java-based client! Nice to meet you!...
   ```

## Wish List

General clean ups, TODOs and things I wish to implement for this project:

* Extend the example to something more complex than an echo server. Have a complex type.
* Why do we need the 'org.apache.tomcat:annotations-api' dependency? Having to specify this dependency and a version for
  this dependency makes gRPC a leakier abstraction (bad).
* Clean up and flesh out the individual sub-project READMEs?
