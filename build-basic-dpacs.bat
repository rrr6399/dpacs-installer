set JAVA_HOME=c:\java\jdk-11
set PATH=%JAVA_HOME%\bin;%PATH%
gradlew -b build-basic-dpacs.gradle clean build makeDpacsInstallers makeAllDpacsBundles -PJDK=11
rem gradlew -b build-basic-dpacs.gradle clean build makeSeraphInstallers makeAllSeraphBundles
pause 
