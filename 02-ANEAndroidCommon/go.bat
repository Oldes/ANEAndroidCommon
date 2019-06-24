@echo off

jar cvf AndroidCommon.jar ANEAndroidCommon-eclipse\bin\classes\*

MKDIR AndroidCommon
CD AndroidCommon
jar -xvf ..\ANEAndroidCommon-studio\app\build\outputs\aar\app-release.aar
MOVE classes.jar ..\AndroidCommon.jar

CD ..

RD  /S /Q AndroidCommon