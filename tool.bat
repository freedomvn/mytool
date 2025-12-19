@echo off
title Khoi Dep Trai Tool

:: --- PHAN KIEM TRA QUYEN ADMIN ---
:check_Permissions
    echo Dang kiem tra quyen Administrator...
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto :menu
    ) else (
        echo Dang yeu cau quyen Admin...
        goto :UACPrompt
    )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %*", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:: --- GIAO DIEN MENU CHINH ---
:menu
cls
color 0B
echo ======================================================
echo           QUAN LY SCRIPT (ONLINE HTTP)
echo ======================================================
echo.
echo  [1] Chay Script Backup  (tu Web)
echo  [2] Chay Script Cleanup (tu Web)
echo  [3] Chay Script Network (tu Web)
echo  [4] Thoat
echo.
echo ======================================================
set /p user_choice="Nhap lua chon cua ban (1-4): "

:: Thay the cac URL duoi day bang link that cua ban (Github, Pastebin, v.v.)
set "URL_BACKUP=https://raw.githubusercontent.com/user/repo/main/backup.bat"
set "URL_CLEANUP=https://raw.githubusercontent.com/user/repo/main/cleanup.bat"
set "URL_NETWORK=https://raw.githubusercontent.com/user/repo/main/network.bat"

if "%user_choice%"=="1" set "target_url=%URL_BACKUP%" & goto :run_online
if "%user_choice%"=="2" set "target_url=%URL_CLEANUP%" & goto :run_online
if "%user_choice%"=="3" set "target_url=%URL_NETWORK%" & goto :run_online
if "%user_choice%"=="4" exit

echo Lua chon khong hop le!
pause
goto menu

:: --- HAM TAI VA CHAY SCRIPT ---
:run_online
cls
echo Dang tai script tu: %target_url%
echo Vui long cho trong giay lat...

:: Cach nay se tai file ve thu muc Temp va thuc thi no
set "temp_script=%temp%\online_script_%random%.bat"

powershell -Command "(New-Object Net.WebClient).DownloadFile('%target_url%', '%temp_script%')"

if exist "%temp_script%" (
    echo Tai thanh cong! Dang thuc thi...
    echo ---------------------------------------------------
    call "%temp_script%"
    del "%temp_script%"
    echo ---------------------------------------------------
    echo Hoan tat!
) else (
    echo [LOI] Khong the ket noi den URL hoac tai file.
)

pause
goto menu