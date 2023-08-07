@echo off
set "currentdownload=%random%"
set "uups=aria2-uups.%currentdownload%.txt"
set "apps=aria2-apps.%currentdownload%.txt"
set "log=aria2-logs.%currentdownload%.txt"
cd /d "%~dp0"
echo. > %log%
set /p "id=Which ID should be downloaded: "
set /p "pack=Select language which should be downloaded: "
set /p "index=Select edition(s) which should be downloaded: "
set /p "folder=To which folder the UUP files should be downloaded: "
echo Selected ID: %id% >> %log%
echo Selected language: %pack% >> %log%
echo Selected editions: %index% >> %log%
choice /c YN /M "Slow Internet? (Y/N)"
if errorlevel 1 set "slowInter=true"
if errorlevel 2 set "slowInter=false"
choice /c YN /M "Download apps? (Y/N)"
if errorlevel 2 goto downloaduups
echo Please wait...
if "%slowInter%"=="true" goto :slowinternet-apps
if "%slowInter%"=="false" goto :normalinternet-apps
echo Apps were downloaded. >> %log%
echo Apps downloading finished.
goto downloaduups

:downloaduups
echo Please wait...
if "%slowInter%"=="true" goto :slowinternet-uups
if "%slowInter%"=="false" goto :normalinternet-uups


:slowinternet-apps
aria2c -o %apps% "https://uupdump.net/findfiles.php?id=%id%&pack=neutral&edition=app&aria2=2" >> %log%
aria2c -i %apps% -d %folder% >> %log%
goto downloaduups

:normalinternet-apps
aria2c -o %apps% "https://uupdump.net/get.php?id=%id%&pack=neutral&edition=app&aria2=2" >> %log%
aria2c -i %apps% -d %folder% >> %log%
goto downloaduups

:slowinternet-uups
aria2c -o %uups% "https://uupdump.net/findfiles.php?id=%id%&pack=%pack%&edition=%index%&aria2=2" >> %log%
aria2c -i %uups% -d %folder% >> %log%
goto finish

:normalinternet-uups
aria2c -o %uups% "https://uupdump.net/get.php?id=%id%&pack=%pack%&edition=%index%&aria2=2" >> %log%
aria2c -i %uups% -d %folder% >> %log%
goto finish

:finish
echo UUPs files finished downloading. >> %log%
echo UUP downloading finished.
pause
goto EOF

:EOF
