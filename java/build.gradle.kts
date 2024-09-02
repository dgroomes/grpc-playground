// Configure all projects to use Maven Central.
// I'm looking forward to when 'dependencyResolutionManagement' is promoted from "Incubating" status. See https://docs.gradle.org/current/userguide/declaring_repositories_adv.html#sub:centralized-repository-declaration
subprojects {
    repositories {
        mavenCentral()
    }
}
