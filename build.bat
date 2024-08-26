set JAVA_HOME=c:\java\jdk-11
set PATH=%JAVA_HOME%\bin;%PATH%
gradlew clean build makeSeraphInstallers makeAllSeraphBundles
rem gradlew makeSeraphInstallers makeAllSeraphBundles
pause
