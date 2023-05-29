plugins {
    application
}

application {
    mainClass.set("dgroomes.ServerMain")
}

dependencies {
    implementation(project(":rpc"))
}
