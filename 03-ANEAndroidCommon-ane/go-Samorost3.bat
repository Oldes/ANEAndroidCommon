@SET AIR_SDK_VERSION=AIRSDK-Windows
::#################################
:: ARMv7 version with support:
@SET ARM_VERSION=ARM
@SET APP_VERSION=Samorost3
@SET ICO_VERSION=
@SET SUPPORT_VERSION=-Support-v27

CALL go-common.bat

@SET ARM_VERSION=ARM
@SET APP_VERSION=Samorost3
@SET ICO_VERSION=-Demo
@SET SUPPORT_VERSION=-Support-v27

CALL go-common.bat

::##################################
:: ARMv7 version without support:

@SET ARM_VERSION=ARM
@SET APP_VERSION=Samorost3
@SET ICO_VERSION=
@SET SUPPORT_VERSION=

CALL go-common.bat

@SET ARM_VERSION=ARM
@SET APP_VERSION=Samorost3
@SET ICO_VERSION=-Demo
@SET SUPPORT_VERSION=

CALL go-common.bat

@SET AIR_SDK_VERSION=AIRSDK-Windows-Harman

::#################################
:: ARMv8 version with support:
@SET ARM_VERSION=ARM64
@SET APP_VERSION=Samorost3
@SET ICO_VERSION=
@SET SUPPORT_VERSION=-Support-v27

CALL go-common.bat

@SET ARM_VERSION=ARM64
@SET APP_VERSION=Samorost3
@SET ICO_VERSION=-Demo
@SET SUPPORT_VERSION=-Support-v27

CALL go-common.bat

::##################################
:: ARMv8 version without support:

@SET ARM_VERSION=ARM64
@SET APP_VERSION=Samorost3
@SET ICO_VERSION=
@SET SUPPORT_VERSION=

CALL go-common.bat

@SET ARM_VERSION=ARM64
@SET APP_VERSION=Samorost3
@SET ICO_VERSION=-Demo
@SET SUPPORT_VERSION=

CALL go-common.bat
