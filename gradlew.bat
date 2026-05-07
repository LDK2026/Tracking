```bat id="x88sx0"
@ECHO OFF

set DIR=%~dp0

java -classpath "%DIR%\gradle\wrapper\gradle-wrapper.jar" ^
org.gradle.wrapper.GradleWrapperMain %*
```
