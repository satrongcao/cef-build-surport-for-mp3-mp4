@echo off

cd /d %~dp0

set DOWNLOAD_DIR=%~dp0\chromium_git
set DEPOT_TOOLS_DIR=%~dp0\depot_tools

set vs_root=C:\Program Files\Microsoft Visual Studio\2022\Professional
set sdk_root=C:\Program Files (x86)\Windows Kits\10
set sdk_version=10.0.22621.0
set vc_tools_version=14.39.33519
set vc_redist_version=14.38.33135
set vc_redist_crt=Microsoft.VC143.CRT
set arch=x64

set CEF_USE_GN=1
set GN_DEFINES=is_official_build=true ffmpeg_branding=Chrome proprietary_codecs=true chrome_pgo_phase=0
set GYP_DEFINES=buildtype=Official
set GYP_MSVS_VERSION=2022
set CEF_ARCHIVE_FORMAT=tar.bz2

set GYP_GENERATORS=ninja,msvs-ninja
set GN_ARGUMENTS=--ide=vs%GYP_MSVS_VERSION% --sln=cef --filters=//cef/*

set WIN_CUSTOM_TOOLCHAIN=1
set CEF_VCVARS=none
set GYP_MSVS_OVERRIDE_PATH=%vs_root%
set VS_CRT_ROOT=%vs_root%\VC\Tools\MSVC\%vc_tools_version%\crt\src\vcruntime
set SDK_ROOT=%sdk_root%

set PATH=%sdk_root%\bin\%sdk_version%\%arch%;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\bin\HostX86\%arch%;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\bin\HostX64\%arch%;%vs_root%\VC\Redist\MSVC\%vc_redist_version%\%arch%\%vc_redist_crt%;%vs_root%\SystemCRT;%PATH%
set INCLUDE=%sdk_root%\Include\%sdk_version%\um;%sdk_root%\Include\%sdk_version%\ucrt;%sdk_root%\Include\%sdk_version%\shared;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\include;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\atlmfc\include;%INCLUDE%
set LIB=%sdk_root%\Lib\%sdk_version%\um\%arch%;%sdk_root%\Lib\%sdk_version\ucrt\%arch%;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\lib\%arch%;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\atlmfc\lib\%arch%;%LIB%

@REM master build
@REM python automate-git.py --download-dir=%DOWNLOAD_DIR% --depot-tools-dir=%DEPOT_TOOLS_DIR% --no-update --no-debug-build --build-log-file --force-distrib --minimal-distrib --client-distrib --verbose-build --%arch%-build

@REM branch build
python automate-git.py --download-dir=%DOWNLOAD_DIR% --depot-tools-dir=%DEPOT_TOOLS_DIR% --no-update --no-debug-build --build-log-file --force-distrib --minimal-distrib --client-distrib  --verbose-build --%arch%-build --branch=4430