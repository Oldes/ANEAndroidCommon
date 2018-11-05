@echo off

jar cvf AndroidCommon.jar ANEAndroidCommon-eclipse\bin\classes\*

MKDIR AndroidCommon
CD AndroidCommon
jar -xvf ..\ANEAndroidCommon\app\build\outputs\aar\app-debug.aar
MOVE classes.jar ..\AndroidCommon.jar

CD ..

RD  /S /Q AndroidCommon