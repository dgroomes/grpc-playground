plugins {
    `java-library`
}

dependencies {
    /*
     * These are the Protobuf and gRPC dependencies needed for Java. The three dependencies map to the high-level
     * components described in the 'grpc-java' project README: https://github.com/grpc/grpc-java#high-level-components
     *   1) Stub ('grpc-stub')
     *   2) Channel ('grpc-protobuf')
     *   3) Transport ('grpc-netty-shaded')
     */
    api(libs.grpc.stub)
    api(libs.grpc.protobuf)
    implementation(libs.grpc.netty)
    compileOnly(libs.tomcat.annotations) // Unfortunately this is a leaky dependency of gRPC Java.
}
