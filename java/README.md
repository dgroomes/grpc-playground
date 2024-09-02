# java

A working example of client- and server-side Java programs that communicate over gRPC.


## Overview

This was inspired from the [official "helloworld" gRPC example for Java](https://github.com/grpc/grpc-java/tree/master/examples)
but significantly diverges because it uses the `protoc` compiler plugin extension mechanism directly instead of using
it via a Gradle plugin which wraps `protoc`. I would prefer to use `protoc` directly because it is a common and familiar
interface. If I learn `protoc` for a Java project, then I can use my `protoc` knowledge in a GoLang project, a
JavaScript project, or a Python project!

**NOTE**: This project was developed on macOS. It is for my own personal use.


## Instructions

Follow these instructions to build and run the server program and client program:

1. Pre-requisite: Java 21
2. Install `protoc`. This is the Protocol Buffers compiler.
    * Download it via the Protocol Buffers [GitHub Releases page](https://github.com/protocolbuffers/protobuf/releases).
      At this time, stick with the 25.x line because 26.x and later depend on the 4.x Java Protobuf library which does
      not work in the gRPC Java library. See [GitHub issue #11015: *Update to Protobuf 4.x*](https://github.com/grpc/grpc-java/issues/11015).
      I spent a couple of hours upgrading to 28.x, then realizing that it fails, then researching, and then downgrading
      to 25.x.
    * For example, I executed the following commands.
    * ```nushell
      do {
          http get --raw https://github.com/protocolbuffers/protobuf/releases/download/v25.4/protoc-25.4-osx-aarch_64.zip | save --force protoc.zip
          unzip protoc.zip
          mv bin/protoc ~/.local/bin
      }
      ```
3. Install the Java gRPC extension for `protoc`
    * Follow the note in [`grpc-java`'s README for the compiler](https://github.com/grpc/grpc-java/tree/master/compiler):
      > Normally you don't need to compile the codegen by yourself, since pre-compiled binaries for common platforms are available on Maven Central:
      >  
      > 1. Navigate to https://mvnrepository.com/artifact/io.grpc/protoc-gen-grpc-java
      > 1. Click into a version
      > 1. Click "Files"
    * Download the latest executable matching your machine architecture, move it somewhere on your PATH, rename it to
      *exactly* `protoc-gen-java-grpc`, make it executable, and remove the quarantine bit if needed. For example, I
      executed these commands on my computer:
      ```nushell
      do {
          http get --raw https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.66.0/protoc-gen-grpc-java-1.66.0-osx-aarch_64.exe | save --force protoc-gen-java-grpc
          if (open --raw protoc-gen-java-grpc | hash sha256) != 56b5ea18bfc0cd08fc3ddbcaff5af0a3b061b3c33de23c6a2d2fb7c487cfe92a {
              print "Hash mismatch. Double check the download and expected hash."
              return 
          }
      
          chmod +x protoc-gen-java-grpc
          mv protoc-gen-java-grpc ~/.local/bin
      }
      ```
4. Generate the Java source code from the Protobuf files
    * With the following command, move into the `rpc/` subproject, and generate the Java source code
    * ```shell
      cd rpc
      ./generate-protobuf-code.sh
      cd ..
      ```
    * This will have created the files `src/main/java/dgroomes/EchoProtos.java` and `src/main/java/dgroomes/EchoGrpc.java`
    * I am choosing to check these files into version control. Alternatively, in your own project, you could gitignore
      the generated code and just build them on-demand as part of your development workflow. That would be the more
      "engineered" approach.
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
   * ```text
     Sep 02, 2024 12:26:19 PM dgroomes.ClientMain sendRequest
     INFO: *Sending* the following message to the server:
     Hello server, I am a Java-based client! Nice to meet you!
     
     Sep 02, 2024 12:26:19 PM dgroomes.ClientMain sendRequest
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
* [ ] Keep an eye on [Helidon's gRPC implementation](https://helidon.io/docs/v1/grpc/01_introduction).
