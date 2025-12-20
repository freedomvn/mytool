@echo off
:: Tu dong nang quyen Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
title Cai Phan Mem Tu Dong

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
echo  4. Zalo              10. VLC Player         16. CapCut PC
echo  5. Telegram          11. Spotify            17. Photoshop
echo  6. Messenger         12. K-Lite Codec       18. OBS Studio
echo.
echo  [ HO TRO TU XA ]
echo  U. Ultraview         T. Teamview
echo.
echo  [ TU DONG ]          
echo  19. CAI GOI CO BAN (Zalo, Unikey, Chrome, 7-Zip, Ultraview)
echo  20. CAI TAT CA       0. THOAT
echo ===============================================================
set /p choice="Nhap lua chon cua ban: "

:: Thiet lap ID phan mem - Them /i de khong phan biet chu hoa/thuong
if /i "%choice%"=="1" set APP=Google.Chrome & goto INSTALL
if /i "%choice%"=="2" set APP=CocCoc.CocCoc & goto INSTALL
if /i "%choice%"=="3" set APP=Mozilla.Firefox & goto INSTALL
if /i "%choice%"=="4" set APP=Zalo.Zalo & goto INSTALL
if /i "%choice%"=="5" set APP=Telegram.TelegramDesktop & goto INSTALL
if /i "%choice%"=="6" set APP=Facebook.Messenger & goto INSTALL
if /i "%choice%"=="7" set APP=Microsoft.Office & goto INSTALL
if /i "%choice%"=="8" set APP=Foxit.FoxitReader & goto INSTALL
if /i "%choice%"=="9" set APP=PhamKimLong.UniKey & goto INSTALL
if /i "%choice%"=="10" set APP=VideoLAN.VLC & goto INSTALL
if /i "%choice%"=="11" set APP=Spotify.Spotify & goto INSTALL
if /i "%choice%"=="12" set APP=CodecGuide.K-LiteCodecPack.Full & goto INSTALL
if /i "%choice%"=="13" set APP=7zip.7zip & goto INSTALL
if /i "%choice%"=="14" set APP=lamquangminh.EVKey & goto INSTALL
if /i "%choice%"=="15" set APP=Tonec.InternetDownloadManager & goto INSTALL
if /i "%choice%"=="16" set APP=ByteDance.CapCut & goto INSTALL
if /i "%choice%"=="17" set APP=Adobe.Photoshop & goto INSTALL
if /i "%choice%"=="18" set APP=obsproject.obs-studio & goto INSTALL
if /i "%choice%"=="U" set APP=DucFabulous.UltraViewer & goto INSTALL
if /i "%choice%"=="T" set APP=TeamViewer.TeamViewer & goto INSTALL
if /i "%choice%"=="19" goto BASIC
if /i "%choice%"=="20" goto ALL
if /i "%choice%"=="0" exit
goto MENU

:INSTALL
echo.
echo [+] Dang cai dat %APP%...
winget install --id %APP% --silent --accept-source-agreements --accept-package-agreements
if %errorLevel% neq 0 echo [!] Co loi xay ra hoac phan mem da co san.
pause
goto MENU

:BASIC
echo.
echo --- DANG CAI GOI CO BAN ---
for %%i in (Google.Chrome Zalo.Zalo PhamKimLong.UniKey 7zip.7zip DucFabulous.UltraViewer) do (
    echo [+] Dang cai %%i...
    winget install --id %%i --silent --accept-source-agreements --accept-package-agreements
)
echo [OK] Hoan thanh!
pause
goto MENU

:ALL
echo.
echo --- DANG CAI TAT CA ---
for %%i in (Google.Chrome Zalo.Zalo PhamKimLong.UniKey 7zip.7zip DucFabulous.UltraViewer VideoLAN.VLC Telegram.TelegramDesktop) do (
    echo [+] Dang cai %%i...
    winget install --id %%i --silent --accept-source-agreements --accept-package-agreements
)
echo [OK] Hoan thanh!
pause
goto MENU
