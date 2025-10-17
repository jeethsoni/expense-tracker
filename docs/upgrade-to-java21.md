Upgrade to Java 21 (manual steps)

This project uses Android/Gradle. The automated Copilot Java upgrade tools are unavailable in this environment, so follow these manual steps to install and configure Java 21 for local builds.

1. Install JDK 21 (recommended: Homebrew or SDKMAN)

Homebrew (macOS - Intel/Apple Silicon):

# install temurin-21
brew install temurin@21

# get installed path
/usr/libexec/java_home -v 21

SDKMAN (alternative):

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 21-open
sdk home java 21-open

2. Point Gradle to JDK 21 for local builds

You can either set `org.gradle.java.home` in `android/gradle.properties` (not committed if you prefer local-only), or pass `-Dorg.gradle.java.home` when invoking the Gradle wrapper.

Example (temporary):

./android/gradlew -p android -Dorg.gradle.java.home="/path/to/jdk21" assembleDebug

Example (project-level): add to `android/gradle.properties`:

org.gradle.java.home=/path/to/jdk21

3. Use Gradle toolchains (recommended)

If your Gradle and Android Gradle Plugin versions support toolchains, configure them in `build.gradle(.kts)`. This repo already targets Java 21 in `android/app/build.gradle.kts` (source/target and Kotlin jvmTarget).

4. Verify build

Run:

./android/gradlew -p android assembleDebug --no-daemon

If Flutter build errors appear (missing Dart files), resolve them separately (the earlier build failed due to missing `lib/expenses.dart`).

Notes
- Gradle 8.12 supports Java 21. The Gradle wrapper in this repo is `gradle-8.12-all.zip`.
- The automated Copilot Java upgrade tools require a paid plan; this work was done manually instead.
