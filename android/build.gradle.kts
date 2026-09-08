allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    val configureSubproject: () -> Unit = {
        if (project.plugins.hasPlugin("com.android.library")) {
            project.extensions.configure<com.android.build.api.dsl.LibraryExtension> {
                compileSdk = 36
            }
        }
    }
    if (project.state.executed) {
        configureSubproject()
    } else {
        project.afterEvaluate { configureSubproject() }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
