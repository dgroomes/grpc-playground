/**
 * Configure all of the sub-projects with common configuration
 */
subprojects {
    apply(plugin = "java")
    repositories {
        mavenLocal()
        jcenter()
    }
}

val client = project(":client")
val server = project(":server")
val rpc = project(":rpc")

/**
 * Configure the client and server sub-projects with the Gradle "application" plugin so that we can execute them via
 * convenient shell "start scripts". Also, declare a dependency on the "rpc" code.
 */
configure(listOf(client, server)) {
    apply(plugin = "application")

    dependencies {
        "implementation"(rpc)
    }
}