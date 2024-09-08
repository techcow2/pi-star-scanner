@echo off
setlocal EnableDelayedExpansion

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
    goto :choose_connection_type
) else if /i "!user_choice!"=="N" (
    echo %RED%Exiting the script. Goodbye!%RESET%
    goto :end
) else (
    echo %RED%Invalid choice. Please enter Y to proceed or N to exit.%RESET%
    goto :ask_to_proceed
)

:choose_connection_type
echo %CYAN%======================================================
echo Is your Pi-Star connected via Ethernet or Wi-Fi?
echo 1. Ethernet
echo 2. Wi-Fi
echo =======================================================
set /p connection_type=Enter your choice (1 or 2): 

if "!connection_type!"=="1" (
    goto :ethernet_scan
) else if "!connection_type!"=="2" (
    goto :wifi_scan
) else (
    echo %RED%Invalid choice. Please enter 1 for Ethernet or 2 for Wi-Fi.%RESET%
    goto :choose_connection_type
)

:ethernet_scan
echo %CYAN%======================================================
echo Scanning for active Ethernet connections...
echo ======================================================%RESET%

setlocal enabledelayedexpansion
set /A count=0
for /f "tokens=1-5 delims=:" %%a in ('ipconfig ^| findstr /R /C:"^Ethernet adapter" /C:"^ *IPv4 Address"') do (
    if "%%a %%b %%c %%d %%e"=="Ethernet adapter" (
        set /A count+=1
        set adapter%%count%%=%%f
        set "description[%%count%%]=%%f"
    )
    if "%%a"=="IPv4" (
        set "ip[%%count%%]=%%c"
    )
)

if !count!==0 (
    echo %RED%No active Ethernet connections found.%RESET%
    goto :end
)

echo %YELLOW%Available Ethernet connections:%RESET%
for /L %%i in (1,1,!count!) do (
    echo %%i. !description[%%i]! (!ip[%%i]!)
)

echo Press the number corresponding to the Ethernet network your Pi-Star is connected to or press [I] for "I don't know": 
set /p ethernet_choice=Enter your choice: 

if /i "!ethernet_choice!"=="I" (
    echo %YELLOW%Scanning all Ethernet connections for Pi-Star...%RESET%
    goto :scan_ethernet_networks
)

if "!ip[%ethernet_choice%]!"=="" (
    echo %RED%Invalid choice. Please try again.%RESET%
    goto :ethernet_scan
)

set selectedEthernetIP=!ip[%ethernet_choice%]!
set baseEthernetIP=!selectedEthernetIP:~0,-1!.
echo %YELLOW%Scanning the selected Ethernet network: !selectedEthernetIP!...%RESET%
goto :scan_ethernet_specific

:scan_ethernet_specific
for /L %%i in (1,1,254) do (
    set ip=!baseEthernetIP!%%i
    echo Checking IP: !ip!
    ping -n 1 -w 30 !ip! | find "TTL=" >nul
    if !errorlevel! equ 0 (
        curl -s --connect-timeout 0.3 -I http://!ip!/ | findstr "200 OK" >nul 2>&1
        if !errorlevel! equ 0 (
            curl -s --connect-timeout 0.3 http://!ip! | findstr /i "pi-star" >nul 2>&1
            if !errorlevel! equ 0 (
                echo %GREEN%Pi-Star found at IP address: !ip!%RESET%
                set found=true
                set piStarIP=!ip!
                goto :open_browser
            )
        )
    )
)
goto :not_found

:scan_ethernet_networks
for /L %%i in (1,1,!count!) do (
    set baseIP=!ip[%%i]:~0,-1!.
    for /L %%j in (1,1,254) do (
        set ip=!baseIP!%%j
        echo Checking IP: !ip!
        ping -n 1 -w 30 !ip! | find "TTL=" >nul
        if !errorlevel! equ 0 (
            curl -s --connect-timeout 0.3 -I http://!ip!/ | findstr "200 OK" >nul 2>&1
            if !errorlevel! equ 0 (
                curl -s --connect-timeout 0.3 http://!ip! | findstr /i "pi-star" >nul 2>&1
                if !errorlevel! equ 0 (
                    echo %GREEN%Pi-Star found at IP address: !ip!%RESET%
                    set found=true
                    set piStarIP=!ip!
                    goto :open_browser
                )
            )
        )
    )
)
goto :not_found

:wifi_scan
echo %CYAN%======================================================
echo Scanning Wi-Fi network range for Pi-Star...
echo ======================================================%RESET%

for /f "tokens=3" %%i in ('netsh interface ip show addresses "Wi-Fi" ^| findstr "IP Address"') do set localIP=%%i

if not defined localIP (
    echo %RED%Could not find an active Wi-Fi connection.%RESET%
    goto :end
)

for /f "tokens=1,2,3 delims=." %%a in ("%localIP%") do set baseIP=%%a.%%b.%%c.

echo %YELLOW%Scanning Wi-Fi network range %baseIP%.x for Pi-Star...%RESET%

set found=false
for /L %%i in (1,1,254) do (
    set ip=%baseIP%%%i
    echo Checking IP: !ip!
    ping -n 1 -w 30 !ip! | find "TTL=" >nul
    if !errorlevel! equ 0 (
        curl -s --connect-timeout 0.3 -I http://!ip!/ | findstr "200 OK" >nul 2>&1
        if !errorlevel! equ 0 (
            curl -s --connect-timeout 0.3 http://!ip! | findstr /i "pi-star" >nul 2>&1
            if !errorlevel! equ 0 (
                echo %GREEN%Pi-Star found at IP address: !ip!%RESET%
                set found=true
                set piStarIP=!ip!
                goto :open_browser
            )
        )
    )
)

:not_found
echo %RED%No Pi-Star device was found.%RESET%
goto :end

:open_browser
if "!found!"=="true" (
    echo %CYAN%Opening the Pi-Star Dashboard in your default web browser...%RESET%
    start http://!piStarIP!
)

:end
echo %CYAN%Press any key to exit...%RESET%
pause >nul
exit
