:: Path to AIR SDK
@call ../setup.bat

@echo Building SWF file

::MKDIR lib
::COPY ..\03-ANEAndroidCommon-ane

java -Dsun.io.useCanonCaches=false -Xms32m -Xmx512m -Dflexlib="%AIR_SDK%\frameworks" -jar "%AIR_SDK%\lib\mxmlc-cli.jar" ^
	-load-config="%AIR_SDK%/frameworks/air-config.xml" -load-config+=TestAndroidCommonConfig.xml +configname=air ^
	-optimize=true -debug=true -o TestAndroidCommon.swf

	
@echo off
	
set BUILD_NAME=Build\TestAndroidCommon-ARMv7.apk

IF EXIST Build GOTO BUILD_DIR_EXISTS
	MKDIR Build
	GOTO BUILD_DIR_READY
:BUILD_DIR_EXISTS

IF NOT EXIST %BUILD_NAME% GOTO BUILD_DIR_READY
	echo Deleting old build...
	DEL /F /Q "%BUILD_NAME%"
:BUILD_DIR_READY

echo Packing new build...

set AIR_NOANDROIDFLAIR=true

@echo on
java -jar ..\..\AIRSDK-Windows\lib\adt.jar -package -target apk-debug -arch armv7 ^
	-storetype pkcs12 -keystore TestAndroidCommon.p12 -storepass fd ^
	%BUILD_NAME%  application.xml TestAndroidCommon.swf icons/* ^
	-extdir ../release/ARM/Basic/

@echo off

IF NOT EXIST  %BUILD_NAME% GOTO NOBUILD
	echo Build ready!
	GOTO INSTALL
:NOBUILD
	echo Build failed!
	GOTO END
:INSTALL

%AIR_SDK%\lib\android\bin\adb install -r %BUILD_NAME%

java -jar %AIR_SDK%\lib\adt.jar -launchApp -platform android -appid com.amanitadesign.TestAndroidCommon

:END

DEL TestAndroidCommon.swf

ECHO 

::@PAUSE

