/**
 * Configure all of the subprojects with common configuration
 */
subprojects {
    apply(plugin = "java")
    repositories {
        mavenCentral()
    }
}

val client = project(":client")
val server = project(":server")
val rpc = project(":rpc")

/**
 * Configure the client and server subprojects with the Gradle "application" plugin so that we can execute them via
 * convenient shell "start scripts". Also, declare a dependency on the "rpc" code.
 */
configure(listOf(client, server)) {
    apply(plugin = "application")

    dependencies {
        "implementation"(rpc)
    }
}
