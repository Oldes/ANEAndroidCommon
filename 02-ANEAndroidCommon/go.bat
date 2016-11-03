@echo off

jar cvf AndroidCommon.jar ANEAndroidCommon-eclipse\bin\classes\*

MKDIR AndroidCommon
MOVE /Y AndroidCommon.jar AndroidCommon/
CD AndroidCommon
jar -xvf  AndroidCommon.jar
DEL AndroidCommon.jar
RD  /S /Q META-INF

MKDIR classes
MOVE /Y ANEAndroidCommon-eclipse/bin/classes/com classes/
CD classes
DEL com\amanitadesign\BuildConfig.class
DEL com\amanitadesign\R*.class

jar cvf AndroidCommon.jar *
MOVE /Y AndroidCommon.jar ../../

CD ../../

RD  /S /Q AndroidCommon