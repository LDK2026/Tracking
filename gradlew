#!/bin/sh
# Gradle wrapper launcher

DIR="$(cd "$(dirname "$0")" && pwd)"

exec "$DIR/gradle/wrapper/gradle-wrapper.jar" \
org.gradle.wrapper.GradleWrapperMain "$@"
