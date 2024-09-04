@echo off
setlocal EnableDelayedExpansion

:: Set code page to UTF-8 to support extended characters (e.g., ©)
chcp 65001 >nul

for /f "tokens=3" %%i in ('reg query HKEY_CURRENT_USER\Console ^| findstr /i "VirtualTerminalLevel"') do (
    if "%%i" neq "1" (
        reg add HKEY_CURRENT_USER\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul
    )
)

set "RED=[31m"
set "GREEN=[32m"
set "YELLOW=[33m"
set "CYAN=[36m"
set "RESET=[0m"

title Pi-Star Network Scanner

echo %CYAN%======================================================
echo Created by W8RJB ©2024 TechRay Apps LLC
echo %YELLOW%Disclaimer: Use this script at your own risk. We are not
echo responsible for any loss or damage caused by running
echo this script.
echo ======================================================%RESET%

:ask_to_proceed
echo %CYAN%Would you like to proceed? [Y/N]%RESET%
set /p user_choice=Enter your choice: 
if /i "!user_choice!"=="Y" (
    goto :continue
) else if /i "!user_choice!"=="N" (
    echo %RED%Exiting the script. Goodbye!%RESET%
    goto :end
) else (
    echo %RED%Invalid choice. Please enter Y to proceed or N to exit.%RESET%
    goto :ask_to_proceed
)

:continue
echo %CYAN%======================================================
echo Welcome to the Pi-Star Network Scanner
echo This script will scan your local Wi-Fi network and find
echo the device running "http://pi-star/".
echo Please wait while we search for the device...
echo ======================================================%RESET%

timeout /t 2 /nobreak >nul

for /f "tokens=3" %%i in ('netsh interface ip show addresses "Wi-Fi" ^| findstr "IP Address"') do set localIP=%%i

if not defined localIP (
    echo %RED%======================================================
    echo Error: Could not find an active Wi-Fi connection.
    echo Make sure your device is connected to a Wi-Fi network.
    echo ======================================================%RESET%
    goto :end
)

for /f "tokens=1,2,3 delims=." %%a in ("%localIP%") do set baseIP=%%a.%%b.%%c.

echo %YELLOW%Scanning Wi-Fi network range %baseIP%.x for Pi-Star...%RESET%

set found=false
for /L %%i in (1,1,254) do (
    set ip=%baseIP%%%i
    echo Checking IP: !ip!
    curl -s --connect-timeout 1 -I http://!ip!/ | findstr "200 OK" >nul 2>&1
    if !errorlevel! equ 0 (
        curl -s --connect-timeout 1 http://!ip! | findstr /i "pi-star" >nul 2>&1
        if !errorlevel! equ 0 (
            echo %GREEN%======================================================
            echo Pi-Star found at IP address: !ip!
            echo ======================================================%RESET%
            set found=true
            set piStarIP=!ip!
            goto :open_browser
        )
    )
)

:open_browser
if "!found!"=="true" (
    echo %CYAN%======================================================
    echo Opening the Pi-Star Dashboard in your default web browser...
    echo ======================================================%RESET%
    start http://!piStarIP!
    goto :end
)

if "!found!"=="false" (
    echo %RED%======================================================
    echo No Pi-Star device was found on the Wi-Fi network.
    echo ======================================================%RESET%
    echo Would you like to display all connected devices on the Wi-Fi network? [Y/N]
    set /p response=Enter your choice: 

    if /i "!response!"=="Y" (
        goto :scan_all_ips
    ) else if /i "!response!"=="Yes" (
        goto :scan_all_ips
    ) else (
        echo %CYAN%======================================================
        echo Thank you for using the Pi-Star Network Scanner.
        echo ======================================================%RESET%
        goto :end
    )
)

:scan_all_ips
echo %YELLOW%======================================================
echo Scanning the Wi-Fi network for all connected devices...
echo ======================================================%RESET%

for /L %%i in (1,1,254) do (
    set ip=%baseIP%%%i
    ping -n 1 -w 50 !ip! | find "TTL=" >nul
    if !errorlevel! equ 0 (
        echo Device found at IP: !ip!
    )
)

echo %CYAN%======================================================
echo The devices above are connected to your Wi-Fi network.
echo To locate Pi-Star, please follow these steps:
echo =======================================================
echo 1. Open your web browser (e.g., Chrome, Firefox, or Edge).
echo 2. In the address bar at the top, type in one of the IP addresses.
echo 3. Press Enter to load the page.
echo 4. Look for the Pi-Star home page.
echo 5. If it's not Pi-Star, try the next IP address.
echo ======================================================%RESET%

:end
echo %CYAN%Press any key to exit...%RESET%
pause >nul
exit
