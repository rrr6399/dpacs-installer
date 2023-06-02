set JAVA_HOME=c:\java\jdk-1.8
set PATH=%JAVA_HOME%\bin;%PATH%
gradlew clean build makeSeraphInstallers makeAllSeraphBundles
rem gradlew makeSeraphInstallers makeAllSeraphBundles
pause
