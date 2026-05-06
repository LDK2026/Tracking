@echo off
set APP_HOME=%~dp0
set WRAPPER_JAR=%APP_HOME%gradle\wrapper\gradle-wrapper.jar
set PROPS=%APP_HOME%gradle\wrapper\gradle-wrapper.properties

if not exist "%WRAPPER_JAR%" (
  echo Downloading Gradle wrapper...
  for /f "tokens=2 delims==" %%a in ('findstr distributionUrl "%PROPS%"') do set DIST_URL=%%a
  set DIST_URL=%DIST_URL:\=\%
  set TMP_DIR=%APP_HOME%\.gradle-tmp
  if not exist "%TMP_DIR%" mkdir "%TMP_DIR%"
  set ZIP=%TMP_DIR%\gradle.zip
  powershell -Command "Invoke-WebRequest -Uri '%DIST_URL%' -OutFile '%ZIP%'"
  powershell -Command "Expand-Archive -Path '%ZIP%' -DestinationPath '%TMP_DIR%' -Force"
  for /r "%TMP_DIR%" %%f in (gradle-wrapper-*.jar) do set JAR_PATH=%%f
  copy "%JAR_PATH%" "%WRAPPER_JAR%" >nul
)

set JAVA_CMD=java
if not "%JAVA_HOME%"=="" set JAVA_CMD=%JAVA_HOME%\bin\java
"%JAVA_CMD%" -jar "%WRAPPER_JAR%" %*
