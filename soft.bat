@echo off
:: Tu dong nang quyen Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
title Auto Install Tool Vietnam Edition

:: --- KIEM TRA VA CAI WINGET ---
winget --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Winget dang thieu. Dang tai ve...
    powershell -Command "Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile .\winget.msixbundle"
    powershell -Command "Add-AppxPackage -Path .\winget.msixbundle"
    del .\winget.msixbundle
    echo [+] Da cai xong Winget. Vui long bat lai file nay!
    pause
    exit
)

:MENU
cls
echo ===============================================================
echo            CONG CU CAI DAT PHAN MEM VIET NAM (AUTO)
echo ===============================================================
echo  [ TRINH DUYET ]      [ VAN PHONG ]         [ CONG CU ]
echo  1. Chrome            7. Office 365         13. WinRAR/7-Zip
echo  2. Coc Coc           8. Foxit Reader       14. EVKey/UniKey
echo  3. Firefox           9. Unikey (Goc)       15. IDM (Download)
echo.
echo  [ LIEN LAC ]         [ GIAI TRI ]          [ DO HOA/EDIT ]
echo  4. Zalo             10. VLC Player         16. CapCut PC
echo  5. Telegram         11. Spotify            17. Photoshop (Beta)
echo  6. Messenger        12. K-Lite Codec       18. OBS Studio
echo  [ Ho Tro Tu Xa ]
echo  U. Ultraview 
echo  T. Teamview
echo.
echo  [ TU DONG ]         
echo  19. CAI GOI CO BAN (Zalo, Unikey, Chrome, WinRAR, Foxit, Ultraview)
echo  20. CAI TAT CA      0. THOAT
echo ===============================================================
set /p choice="Nhap so (0-20): "

:: Thiet lap ID phan mem
if "%choice%"=="1" set APP=Google.Chrome & goto INSTALL
if "%choice%"=="2" set APP=CocCoc.CocCoc & goto INSTALL
if "%choice%"=="3" set APP=Mozilla.Firefox & goto INSTALL
if "%choice%"=="4" set APP=Zalo.Zalo & goto INSTALL
if "%choice%"=="5" set APP=Telegram.TelegramDesktop & goto INSTALL
if "%choice%"=="6" set APP=Facebook.Messenger & goto INSTALL
if "%choice%"=="7" set APP=Microsoft.Office & goto INSTALL
if "%choice%"=="8" set APP=Foxit.FoxitReader & goto INSTALL
if "%choice%"=="9" set APP=PhamKimLong.UniKey & goto INSTALL
if "%choice%"=="10" set APP=VideoLAN.VLC & goto INSTALL
if "%choice%"=="11" set APP=Spotify.Spotify & goto INSTALL
if "%choice%"=="12" set APP=CodecGuide.K-LiteCodecPack.Full & goto INSTALL
if "%choice%"=="13" set APP=7zip.7zip & goto INSTALL
if "%choice%"=="14" set APP=lamquangminh.EVKey & goto INSTALL
if "%choice%"=="15" set APP=Tonec.InternetDownloadManager & goto INSTALL
if "%choice%"=="16" set APP=ByteDance.CapCut & goto INSTALL
if "%choice%"=="17" set APP=Adobe.Photoshop & goto INSTALL
if "%choice%"=="18" set APP=obsproject.obs-studio & goto INSTALL
if "%choice%"=="U" set APP=DucFabulous.UltraViewer & goto INSTALL
if "%choice%"=="T" set APP=TeamViewer.TeamViewer & goto INSTALL
if "%choice%"=="19" goto BASIC
if "%choice%"=="20" goto ALL
if "%choice%"=="0" exit
goto MENU

:INSTALL
echo.
echo [+] Dang cai dat %APP%...
winget install --id %APP% --silent --accept-source-agreements --accept-package-agreements
if %errorLevel% neq 0 echo [!] Loi khi cai %APP%.
pause
goto MENU

:BASIC
echo.
echo --- DANG CAI GOI CO BAN CHO NGUOI VIET ---
for %%i in (Google.Chrome Zalo.Zalo PhamKimLong.UniKey 7zip.7zip Foxit.FoxitReader DucFabulous.UltraViewer) do (
    echo [+] Dang cai %%i...
    winget install --id %%i --silent --accept-source-agreements --accept-package-agreements
)
echo [OK] Hoan thanh goi co ban!
pause
goto MENU

:ALL
echo.
echo --- DANG CAI TAT CA ---
for %%i in (Google.Chrome CocCoc.CocCoc Zalo.Zalo Telegram.TelegramDesktop Facebook.Messenger Foxit.FoxitReader EVKey.EVKey 7zip.7zip VideoLAN.VLC ByteDance.CapCut Spotify.Spotify,DucFabulous.UltraViewer,TeamViewer.TeamViewer) do (
    echo [+] Dang tai va cai %%i...
    winget install --id %%i --silent --accept-source-agreements --accept-package-agreements
)
echo [OK] Tat ca phan mem da duoc cai dat!
pause

goto MENU



