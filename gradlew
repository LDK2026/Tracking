#!/usr/bin/env sh
# Minimal Gradle wrapper bootstrap
APP_HOME=$(cd "$(dirname "$0")"; pwd)
WRAPPER_JAR="$APP_HOME/gradle/wrapper/gradle-wrapper.jar"
PROPS="$APP_HOME/gradle/wrapper/gradle-wrapper.properties"

if [ ! -f "$WRAPPER_JAR" ]; then
  echo "Downloading Gradle wrapper..."
  DIST_URL=$(grep distributionUrl "$PROPS" | cut -d'=' -f2 | sed 's#\\:#:#g')
  TMP_DIR="$APP_HOME/.gradle-tmp"
  mkdir -p "$TMP_DIR"
  ZIP="$TMP_DIR/gradle.zip"
  if command -v curl >/dev/null 2>&1; then
    curl -L "$DIST_URL" -o "$ZIP"
  else
    wget "$DIST_URL" -O "$ZIP"
  fi
  unzip -q "$ZIP" -d "$TMP_DIR"
  JAR_PATH=$(find "$TMP_DIR" -name "gradle-wrapper-*.jar" | head -n 1)
  mkdir -p "$(dirname "$WRAPPER_JAR")"
  cp "$JAR_PATH" "$WRAPPER_JAR"
fi

JAVA_CMD=${JAVA_HOME:+$JAVA_HOME/bin/}java
exec "$JAVA_CMD" -jar "$WRAPPER_JAR" "$@"
