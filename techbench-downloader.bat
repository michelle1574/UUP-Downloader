@echo off
cd /d "%~dp0"
set "CurrentDownload=%random%"
set "log=download-log%currentdownload%.txt"
echo. > %log%
set "DownloadScript=aria2c-script%CurrentDownload%.txt"
set /p "id=Select the ID: "
set /p "lang=Select the language: "
set /p "editions=Select the edition: "
set /p "folder=Select the folder to download it: "
echo Selected ID: %id% >> %log%
echo Selected language: %lang% >> %log%
echo Selected edition: %editions% >> %log%
echo Selected folder: %folder% >> %log%
echo Please wait...
aria2c -o %DownloadScript% "https://uup.rg-adguard.net/api/GetFiles?id=%id%&lang=%lang%&edition=%editions%&txt=yes" >> %log%
aria2c -i %DownloadScript% -d %folder% >> %log%
echo Download finished >> %log%
echo Download finished.
pause
exit /b