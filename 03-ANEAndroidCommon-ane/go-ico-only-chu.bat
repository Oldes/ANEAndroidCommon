:: Path to AIR SDK
@call ../setup.bat

call clean.bat

mkdir src\assets
copy "..\01-ANEAndroidCommon-swc\com.amanitadesign.AndroidCommon.swc" src\assets

xcopy /S /Y res-chu\* src\assets\platform\Android-ARM\
::xcopy /S /Y res-chu\* src\assets\platform\Android-x86\

::xcopy /S /Y res-Support\* src\assets\platform\Android-ARM\
::xcopy /S /Y res-AppCompat\* src\assets\platform\Android-x86\
::xcopy /S /Y libs-AppCompat\* src\assets\platform\Android-x86\libs\x86\
::xcopy /S /Y libs-AppCompat\* src\assets\platform\Android-ARM\libs\armeabi-v7a\

::uncomment for Chuchel adaptive icon assets
xcopy /S /Y res-icon-chu src\assets\platform\Android-ARM\
::xcopy /S /Y res-icon-chu src\assets\platform\Android-x86\

mkdir src\assets\swc-contents
pushd src\assets\swc-contents
JAR xf ..\com.amanitadesign.AndroidCommon.swc catalog.xml library.swf
popd

mkdir src\assets\platform
mkdir src\assets\platform\Android-ARM
::mkdir src\assets\platform\Android-x86

copy "..\02-ANEAndroidCommon\AndroidCommon.jar" src\assets\platform\Android-ARM
copy src\assets\swc-contents\library.swf src\assets\platform\Android-ARM

::copy "..\02-ANEAndroidCommon\AndroidCommon.jar" src\assets\platform\Android-x86
::copy src\assets\swc-contents\library.swf src\assets\platform\Android-x86

java -jar "%AIR_SDK%\lib\adt.jar" -package                     ^
	-target ane ANEAndroidCommon-chu-noSupport.ane src\extension.xml    ^
	-swc src\assets\com.amanitadesign.AndroidCommon.swc   ^
	-platform Android-ARM -platformoptions src\platform-android-no-support.xml -C src\assets\platform\Android-ARM .
::	-platform Android-x86 -platformoptions src\platform-android.xml -C src\assets\platform\Android-x86 . 

RD  /S /Q .\src\assets

