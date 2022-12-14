set JAVA_HOME=c:\java\jdk1.8
set PATH=%JAVA_HOME%\bin;%PATH%
gradlew -b build-basic-dpacs.gradle clean build makeDpacsInstallers makeAllDpacsBundles
rem gradlew -b build-basic-dpacs.gradle clean build makeSeraphInstallers makeAllSeraphBundles
pause -1
