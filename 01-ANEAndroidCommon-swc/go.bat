:: Path to AIR SDK
@call ../setup.bat

@IF EXIST com.amanitadesign.AndroidCommon.swc DEL com.amanitadesign.AndroidCommon.swc

@echo.
"%AIR_SDK%"/bin/acompc -namespace http://amanita-design.net/extensions src/manifest.xml ^
    -swf-version 33     ^
    -source-path src	^
    -include-classes	^
    com.amanitadesign.AndroidCommon	^
    -output=com.amanitadesign.AndroidCommon.swc

