@echo off
rem -L/IMPLIB
rem ..\..\..\windows\bin\dmd test.d mydll.lib
echo compiling...
dmd -m64 -shared -ofsample_extension.dll ..\src\d\dart.d dll.d ..\dart\lib\x64\dart.lib sample_extension.def %1 %2 %3 %4 %5

if %errorlevel% neq 0 goto EXIT
rem dart main.dart
:EXIT
