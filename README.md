# Pi-Star Network Scanner

Welcome to the **Pi-Star Network Scanner**! This is a simple, user-friendly script that helps you find the local IP address of a Pi-Star device on your Wi-Fi or Ethernet network.

### Created by: W8RJB ©2024 TechRay Apps LLC

---

## Table of Contents

1. [What's New](#whats-new)
2. [What is Pi-Star Network Scanner?](#what-is-pi-star-network-scanner)
3. [How Does it Work?](#how-does-it-work)
4. [Requirements](#requirements)
5. [How to Use](#how-to-use)
6. [Disclaimer](#disclaimer)
7. [VirusTotal Report](#virustotal-report)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)

---

## What's New

### **New Features in the Latest Update (2024):**
- **Ethernet Support**: The script now supports scanning **Ethernet networks** in addition to Wi-Fi. You can choose whether your Pi-Star is connected via Ethernet or Wi-Fi during setup.
- **Faster Scanning**: The scanning process has been optimized with reduced timeout settings and improved IP filtering for quicker results.
- **Ping Pre-Check**: A faster, more efficient network scan using `ping` to check if devices are reachable before checking for Pi-Star. This helps reduce the number of unnecessary connection attempts.
- **Connection Type Selection**: Users can now easily select whether their Pi-Star is connected via **Ethernet** or **Wi-Fi**. If you're unsure, an option to scan all networks is available.
- **Parallel Scanning**: The script now supports limited parallel network scanning for faster discovery of Pi-Star devices.

---

## What is Pi-Star Network Scanner?

Pi-Star Network Scanner is a Windows batch script that scans your local network (Wi-Fi or Ethernet) to find the **Pi-Star** device. This script is perfect for anyone who has a Pi-Star setup (used in digital voice hotspots for amateur radio) and wants to quickly locate the device's IP address on the network.

---

## How Does it Work?

The script now supports **both Ethernet and Wi-Fi** scanning and works as follows:
- Prompts you to choose whether your Pi-Star is connected via **Ethernet** or **Wi-Fi**.
- Scans your selected network for any device hosting the **Pi-Star** software.
- Displays the IP address of the Pi-Star device if found.
- Automatically opens the Pi-Star Dashboard in your default web browser once it's located.
- Includes faster scanning with optimized timeouts and intelligent filtering of unreachable devices.

If no Pi-Star device is found, the script will give you the option to display all connected devices on your network so that you can manually try opening their IP addresses in your browser.

### Optimizations in Scanning:
- **Faster Scan**: Reduced timeout duration during scanning for quicker results.
- **Ping Pre-Check**: The script pings each device to ensure it is reachable before checking for Pi-Star, which speeds up the process.
- **Parallel Execution**: The script now supports running multiple pings or checks in parallel to speed up the scan.

---

## Requirements

Before running the script, make sure you have:
- A **Windows PC** (Windows 10 or newer recommended).
- A Pi-Star device connected to the **same network (Ethernet or Wi-Fi)** as your PC.
- Internet access for downloading the script and scanning your network.

---

## How to Use

### Step 1: Download the Script
1. Download the `PiStarScanner.bat` file from this repository by clicking the **Code** button and selecting **Download ZIP**.
2. Extract the ZIP file on your computer.

### Step 2: Run the Script
1. Double-click the `PiStarScanner.bat` file to run it.
2. You will see a welcome screen with a disclaimer about using the script.
3. After reading the information, you'll be asked if you want to proceed:
   - Type `Y` to proceed with the scan.
   - Type `N` to exit the script.

### Step 3: Select Your Connection Type
1. You'll be prompted to choose whether your Pi-Star is connected to your network via **Ethernet** or **Wi-Fi**.
   - Press `1` for Ethernet.
   - Press `2` for Wi-Fi.

2. If you select Ethernet, a list of active Ethernet connections (including their IP addresses and descriptions) will be displayed. 
   - You can either select the Ethernet network by pressing the corresponding number or press `I` to scan **all active Ethernet connections** if you're unsure.

3. If you select Wi-Fi, the script will begin scanning your Wi-Fi network for Pi-Star.

### Step 4: View Results
- **If Pi-Star is found**, the script will display the device's **IP address** and automatically open the Pi-Star Dashboard in your web browser.
- **If Pi-Star is not found**, you will be given the option to display all connected devices on the network for manual exploration.

### Step 5: Troubleshooting (if Pi-Star is not found)
- If the script doesn’t find Pi-Star, it will ask if you want to display all connected devices on your network.
- If you agree (`Y`), it will show the IP addresses of all devices on your network. You can manually try these IP addresses in your web browser to locate Pi-Star.

---

## Disclaimer

**Use this script at your own risk.**
While I've done my best to make the Pi-Star Network Scanner safe and easy to use, TechRay Apps LLC is not responsible for any damage, loss, or issues that may occur while using this script. By using the Pi-Star Network Scanner, you agree to these terms.

**Affiliation Disclaimer:** This project is **not affiliated** with or endorsed by **Pi-Star** or its developers. Pi-Star is a separate project and trademark of its respective owners.

---

## VirusTotal Report

To ensure transparency and trust, you can view the security report for this script from VirusTotal:

**[VirusTotal Scan Report](https://www.virustotal.com/gui/file/162ecbc8b1c89135cbfd95b4c2c6e0492fea964ea6f563f6e4d1e385512e11d8?nocache=1)**

This report shows that the script is free of malware or other harmful components.

---

## Troubleshooting

### Common Issues:

1. **Pi-Star not found:**
   - Make sure your Pi-Star device is powered on and connected to the same Wi-Fi or Ethernet network as your computer.
   - Ensure that your Wi-Fi or Ethernet connection is active and stable.

2. **Script shows an error:**
   - If you encounter any unexpected errors, try restarting the script or your computer.
   - Make sure your computer is running Windows 10 or newer.

3. **Pi-Star Dashboard doesn’t open:**
   - Ensure your default web browser is set correctly in Windows.
   - Try manually entering the IP address into the browser’s address bar.

4. **Scanning is slow:**
   - The script has been optimized for faster scanning with reduced timeouts and parallel checks. However, the speed may depend on the number of devices on your network or your PC's performance.

### Need more help?
If you need assistance or run into issues, feel free to create an **issue** in the GitHub repository or reach out to the community for help.

---

## Contributing

We welcome contributions from everyone! If you have suggestions or would like to improve this script, feel free to:
- Fork this repository.
- Make your changes.
- Submit a pull request.

---

Thank you for using **Pi-Star Network Scanner**! I hope this tool makes finding your Pi-Star device easier.

---

### Summary of Recent Changes:
- Added **Ethernet support** for users who connect Pi-Star via Ethernet instead of Wi-Fi.
- Implemented **faster network scanning** with reduced timeouts and intelligent pre-checks using `ping`.
- Users can now select **Ethernet or Wi-Fi** easily and, if unsure, scan all active networks.
