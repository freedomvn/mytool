@echo off
echo ---------------------------------------------------
echo DANG THIET LAP MUI GIO +7 (BANGKOK, HANOI, JAKARTA)
echo ---------------------------------------------------

:: Thiet lap mui gio sang SE Asia Standard Time (UTC+07:00)
tzutil /s "SE Asia Standard Time"

echo Da thay doi mui gio thanh cong.

echo.
echo ---------------------------------------------------
echo DANG DONG BO LAI THOI GIAN VOI MAY CHU
echo ---------------------------------------------------

:: Khoi dong lai dich vu thoi gian Windows
net stop w32time
net start w32time

:: Cuong che dong bo thoi gian
w32tm /resync /force

echo.
echo Hoan tat! Gio he thong cua ban da duoc cap nhat.

pause
