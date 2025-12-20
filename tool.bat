@echo off
title Khoi Dep Trai Tool

:: --- PHAN 1: KIEM TRA QUYEN ADMIN TRUOC TIEN ---
:check_Permissions
    net session >nul 2>&1
    if %errorLevel% neq 0 (
        echo Dang yeu cau quyen Admin...
        echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
        echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %*", "", "runas", 1 >> "%temp%\getadmin.vbs"
        "%temp%\getadmin.vbs"
        del "%temp%\getadmin.vbs"
        exit /B
    )

:: --- PHAN 2: KIEM TRA VA CAI WINGET VAO TEMP ---
winget --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Khong tim thay Winget. Dang tien hanh tai va cai dat tu dong...
    
    :: Thiet lap duong dan file trong thu muc Temp
    set "WINGET_PATH=%temp%\winget_installer_%random%.msixbundle"
    
    :: Tai file tu GitHub Microsoft vao Temp
    echo [+] Dang tai Winget vao thu muc Temp...
    powershell -Command "Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile '!WINGET_PATH!'"
    
    echo [+] Dang cai dat Winget...
    powershell -Command "Add-AppxPackage -Path '!WINGET_PATH!'"
    
    :: Cap nhat PATH de su dung ngay
    set "PATH=%PATH%;%LOCALAPPDATA%\Microsoft\WindowsApps"
    
    :: Xoa file sau khi cài
    if exist "!WINGET_PATH!" del /f /q "!WINGET_PATH!"
    echo [+] Da cai dat va don dep file tam thanh cong!
    timeout /t 2 >nul
)

:: --- PHAN 3: GIAO DIEN MENU CHINH ---
:menu
cls
color 0B
echo ======================================================
echo             QUAN LY SCRIPT (ONLINE HTTP)
echo ======================================================
echo.
echo  [1] Dong Bo Gio
echo  [2] Tool Cai Phan Mem
echo  [3] Chay Script Network (tu Web)
echo  [4] Thoat
echo.
echo ======================================================
set /p user_choice="Nhap lua chon cua ban (1-4): "

:: Link script cua ban
set "TIME=https://raw.githubusercontent.com/freedomvn/mytool/refs/heads/main/time.bat"
set "PHANMEM=https://raw.githubusercontent.com/freedomvn/mytool/refs/heads/main/soft.bat"
set "URL_NETWORK=https://raw.githubusercontent.com/user/repo/main/network.bat"

if "%user_choice%"=="1" set "target_url=%TIME%" & goto :run_online
if "%user_choice%"=="2" set "target_url=%PHANMEM%" & goto :run_online
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

:: Tai file ve Temp voi ten ngau nhien de tranh trung lap
set "temp_script=%temp%\online_script_%random%.bat"

powershell -Command "(New-Object Net.WebClient).DownloadFile('%target_url%', '%temp_script%')"

if exist "%temp_script%" (
    echo Tai thanh cong! Dang thuc thi...
    echo ---------------------------------------------------
    call "%temp_script%"
    :: Xoa script ngay sau khi chay xong
    del /f /q "%temp_script%"
    echo ---------------------------------------------------
    echo Hoan tat va da xoa file tam!
) else (
    echo [LOI] Khong the ket noi den URL hoac tai file.
)

pause
goto menu
