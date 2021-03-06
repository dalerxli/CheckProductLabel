@echo off

rem cleanup temporary stuff
call clean.cmd

echo Refreshing license...
copy /y ..\..\checklabel\License.rtf . 

echo Copying MSI tools...
copy /y e:\mdev\lightning_cube\SRC\oem\msistuff.exe . 
copy /y e:\mdev\lightning_cube\SRC\oem\setup.exe .

rem build the installation package
echo.
echo Building installer
"c:\Program Files\Windows Installer XML v3\bin\candle" -sw -wx -nologo checklabel.wsx MyExitDialog.wxs MyWixUI_InstallDir.wxs

"c:\Program Files\Windows Installer XML v3\bin\light" -sw -wx -out checklabel.msi -nologo checklabel.wixobj MyExitDialog.wixobj MyWixUI_InstallDir.wixobj -ext "D:\Program Files\Windows Installer XML v3\bin\WixUIExtension.dll"

msistuff setup.exe /d checklabel.msi /n "CheckLabelDemo" /o INSTALLUPD /v 300 /w InstMsiW.exe 

"c:\program files\7-Zip\7z.exe" a -tzip -mx8 checklabeldemo.zip setup.exe checklabel.msi

"c:\program files\Chilkat Software Inc\ZIP 2 Secure EXE\ChilkatZipSE.exe" -autotemp -run setup.exe checklabeldemo.zip

echo.
echo Ready
