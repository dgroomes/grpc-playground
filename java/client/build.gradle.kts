plugins {
    application
}

application {
    mainClass.set("dgroomes.ClientMain")
}

dependencies {
    implementation(project(":rpc"))
}
