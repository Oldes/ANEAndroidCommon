@SET AIR_SDK_VERSION=AIRSDK-Windows-Harman

::#################################
:: ARMv7/v8 version with support:
@SET ARM_VERSION=ALL
@SET APP_VERSION=Basic
@SET ICO_VERSION=
@SET SUPPORT_VERSION=-Support-v27

CALL go-common.bat


::##################################
:: ARMv7/v8 version without support:

@SET ARM_VERSION=ALL
@SET APP_VERSION=Basic
@SET ICO_VERSION=
@SET SUPPORT_VERSION=

CALL go-common.bat
