@RD  /S /Q .\src\assets

SET TARGET_DIR="..\release\%ARM_VERSION%%SUPPORT_VERSION%\%APP_VERSION%%ICO_VERSION%"
@mkdir "%TARGET_DIR%"
@mkdir src\assets
copy "..\01-ANEAndroidCommon-swc\com.amanitadesign.AndroidCommon.swc" src\assets
@mkdir src\assets\swc-contents
@pushd src\assets\swc-contents
JAR xf ..\com.amanitadesign.AndroidCommon.swc catalog.xml library.swf
@popd

@ECHO \n==========================================

@IF "%ARM_VERSION%"=="ALL" GOTO UNIVERSIAL
	
	@ECHO Making version with %ARM_VERSION% resources\n

	xcopy /S /Y %APP_VERSION%\res\* src\assets\platform\Android-%ARM_VERSION%\
	xcopy /S /Y %APP_VERSION%\res-icon%ICO_VERSION% src\assets\platform\Android-%ARM_VERSION%\
	copy "..\02-ANEAndroidCommon\AndroidCommon.jar" src\assets\platform\Android-%ARM_VERSION%
	copy src\assets\swc-contents\library.swf src\assets\platform\Android-%ARM_VERSION%
	IF DEFINED SUPPORT_VERSION (
		xcopy /S /Y res%SUPPORT_VERSION%\* src\assets\platform\Android-%ARM_VERSION%\
	)
	java -jar "..\..\%AIR_SDK_VERSION%\lib\adt.jar" -package ^
		-target ane %TARGET_DIR%\ANEAndroidCommon.ane src\extension-%ARM_VERSION%.xml ^
		-swc src\assets\com.amanitadesign.AndroidCommon.swc ^
		-platform Android-%ARM_VERSION% -platformoptions src\platform-android%SUPPORT_VERSION%.xml -C src\assets\platform\Android-%ARM_VERSION% .
	GOTO END

:UNIVERSIAL
	@ECHO Making version with both ARMv7 and ARMv8 resources\n

	xcopy /S /Y %APP_VERSION%\res\* src\assets\platform\Android-ARM\
	xcopy /S /Y %APP_VERSION%\res-icon%ICO_VERSION% src\assets\platform\Android-ARM\
	copy "..\02-ANEAndroidCommon\AndroidCommon.jar" src\assets\platform\Android-ARM
	copy src\assets\swc-contents\library.swf src\assets\platform\Android-ARM
	IF DEFINED SUPPORT_VERSION (
		xcopy /S /Y res%SUPPORT_VERSION%\* src\assets\platform\Android-ARM\
	)

	::xcopy /S /Y src\assets\platform\Android-ARM\* src\assets\platform\Android-ARM64\

	java -jar "..\..\%AIR_SDK_VERSION%\lib\adt.jar" -package ^
		-target ane %TARGET_DIR%\ANEAndroidCommon.ane src\extension-all.xml ^
		-swc src\assets\com.amanitadesign.AndroidCommon.swc ^
		-platform Android-ARM -C src\assets\platform\Android-ARM . ^
		-platformoptions src\platform-android%SUPPORT_VERSION%.xml ^
		-platform Android-ARM64 -C src\assets\platform\Android-ARM . ^
		-platformoptions src\platform-android%SUPPORT_VERSION%.xml
		

:END

RD  /S /Q .\src\assets

