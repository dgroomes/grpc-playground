# java

A working example of client- and server-side Java programs that communicate over gRPC.


## Description

This was inspired from the [official "helloworld" gRPC example for Java](https://github.com/grpc/grpc-java/tree/master/examples)
but significantly diverges because it uses the `protoc` compiler plugin extension mechanism directly instead of using
it via a Gradle plugin which wraps `protoc`. I would prefer to use `protoc` directly because it is a common and familiar
interface. If I learn `protoc` for a Java project, then I can use my `protoc` knowledge in a GoLang project, a
JavaScript project, or a Python project!

**NOTE**: This project was developed on macOS. It is for my own personal use.


## Instructions

Follow these instructions to build and run the server program and client program:

1. Use Java 17
    * I use [SDKMAN](https://sdkman.io/) to manage my installations of Java
2. Install `protoc`. This is the Protocol Buffers compiler.
    * Download it via the Protocol Buffers [GitHub Releases page](https://github.com/protocolbuffers/protobuf/releases).
      For example, [protoc-23.2-osx-aarch_64.zip](https://github.com/protocolbuffers/protobuf/releases/download/v23.2/protoc-23.2-osx-aarch_64.zip)
    * Unzip it and then remove the quarantine bit on the `protoc` binary with a command like the following.
    * ```shell
      sudo xattr -d com.apple.quarantine bin/protoc
      ```
    * Add it to your `PATH`
3. Install the Java gRPC extension for `protoc`
    * Follow the note in [`grpc-java`'s README for the compiler](https://github.com/grpc/grpc-java/tree/master/compiler):
      > Normally you don't need to compile the codegen by yourself, since pre-compiled binaries for common platforms are available on Maven Central:
      >  
      > 1. Navigate to https://mvnrepository.com/artifact/io.grpc/protoc-gen-grpc-java
      > 1. Click into a version
      > 1. Click "Files"
    * Note: while there appears to be an ARM64 (`aarh_64`) binary for the `protoc-gen-grpc-java` compiler plugin, it
      does not work on my Apple Silicon Mac. I got the error "Bad CPU type in executable". I've downloaded the x86 one
      instead, and I'm using Rosetta emulation. Follow [GitHub issue](https://github.com/grpc/grpc-java/issues/7690)
      for this problem.
    * For example, [protoc-gen-grpc-java-1.55.1-osx-x86_64.exe](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.55.1/protoc-gen-grpc-java-1.55.1-osx-x86_64.exe)
    * Move it somewhere on your PATH, rename it to *exactly* `protoc-gen-java-grpc`, make it executable, remove the
      quarantine bit. For example, I executed these commands on my computer:
      ```shell
      sudo mv ~/Downloads/protoc-gen-grpc-java-1.55.1-osx-x86_64.exe /usr/local/bin/protoc-gen-java-grpc
      chmod +x /usr/local/bin/protoc-gen-java-grpc
      sudo xattr -d com.apple.quarantine /usr/local/bin/protoc-gen-java-grpc
      ```
4. Generate the Java source code from the Protobuf files
    * Move into the `rpc/` subproject: `cd rpc`
    * Generate the Java source with: `./generate-protobuf-code.sh`
    * This will have created the files `src/main/java/dgroomes/EchoProtos.java` and `src/main/java/dgroomes/EchoGrpc.java`
    * I am choosing to check these files into version control. Alternatively, in your own project, you could gitignore
      the generated code and just build them on-demand as part of your development workflow. That would be the more
      "engineered" approach.
    * Return to the root of the subproject: `cd ..` 
5. Build the project:
   * ```shell
     ./gradlew installDist
     ``` 
6. Run the "echo" server:
   * ```shell
     server/build/install/server/bin/server
     ```
   * You should see output like this:
     ```text
     May 27, 2023 5:28:06 PM dgroomes.ServerMain main
     INFO: Listening for requests...
     ```
7. Run the client
   * Open a new terminal and run the following command.
   * ```shell
     client/build/install/client/bin/client
     ```
   * You should see output like this:
     ```text
     May 27, 2023 5:28:48 PM dgroomes.ClientMain sendRequest
     INFO: *Sending* the following message to the server:
     Hello server, I am a Java-based client! Nice to meet you!
     
     May 27, 2023 5:28:48 PM dgroomes.ClientMain sendRequest
     INFO: *Received* the following response from the server:
     Hello server, I am a Java-based client! Nice to meet you!...
     Hello server, I am a Java-based client! Nice to meet you!...
     Hello server, I am a Java-based client! Nice to meet you!...
     ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [ ] Extend the example to something more complex than an echo server. Have a complex type.
* [ ] Why do we need the 'org.apache.tomcat:annotations-api' dependency? Having to specify this dependency and a version for
  this dependency makes gRPC a leakier abstraction (bad).
* [x] DONE Use a Gradle version catalog with TOML 
