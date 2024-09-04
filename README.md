# Pi-Star Network Scanner

Welcome to the **Pi-Star Network Scanner**! This is a simple, user-friendly script that helps you find the local IP address of a Pi-Star device on your Wi-Fi network.
### Created by: W8RJB ©2024 TechRay Apps LLC

---

## Table of Contents

1. [What is Pi-Star Network Scanner?](#what-is-pi-star-network-scanner)
2. [How Does it Work?](#how-does-it-work)
3. [Requirements](#requirements)
4. [How to Use](#how-to-use)
5. [Disclaimer](#disclaimer)
6. [VirusTotal Report](#virustotal-report)
7. [Troubleshooting](#troubleshooting)
8. [Contributing](#contributing)

---

## What is Pi-Star Network Scanner?

Pi-Star Network Scanner is a Windows batch script that scans your local Wi-Fi network to find the **Pi-Star** device. This script is perfect for anyone who has a Pi-Star setup (used in digital voice hotspots for amateur radio) and wants to quickly locate the device's IP address on the network without needing any technical skills.

---

## How Does it Work?

The script:
- Scans your Wi-Fi network for any device hosting the **Pi-Star** software.
- Displays the IP address of the Pi-Star device if found.
- Automatically opens the Pi-Star Dashboard in your default web browser once it's located.

If no Pi-Star device is found, the script will give you the option to display all connected devices on your network so that you can try manually opening their IP addresses in your browser.

---

## Requirements

Before running the script, ensure you have:
- A **Windows PC** (Windows 10 or newer recommended).
- A Pi-Star device connected to the **same Wi-Fi network** as your PC.
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

### Step 3: Scan Your Network
1. If you proceed, the script will automatically start scanning your Wi-Fi network.
2. If the Pi-Star device is found, the script will display its **IP address** and open the Pi-Star Dashboard in your web browser.

### Step 4: Troubleshooting (if Pi-Star is not found)
- If the script doesn’t find Pi-Star, it will ask if you want to display all connected devices on your network.
- If you agree (`Y`), it will show the IP addresses of all devices on your network. You can manually try these IP addresses in your web browser to locate Pi-Star.

---

## Disclaimer

**Use this script at your own risk.**
While we've done our best to make the Pi-Star Network Scanner safe and easy to use, TechRay Apps LLC and the creators are not responsible for any damage, loss, or issues that may occur while using this script. By using the Pi-Star Network Scanner, you agree to these terms.

**Affiliation Disclaimer:** This project is **not affiliated** with or endorsed by **Pi-Star** or its developers. Pi-Star is a separate project and trademark of its respective owners.

---

## VirusTotal Report

To ensure transparency and trust, you can view the security report for this script from VirusTotal:

**[VirusTotal Scan Report](https://www.virustotal.com/gui/file/3d30bacb9f7a16ec7dbc42f5ce3e5d205d2c586fe3cd7c176ed6c1be56d10a81/detection)**

This report shows that the script is free of malware or other harmful components.

---

## Troubleshooting

### Common Issues:

1. **Pi-Star not found:**
   - Make sure your Pi-Star device is powered on and connected to the same Wi-Fi network as your computer.
   - Ensure that your Wi-Fi is active and the network connection is stable.

2. **Script shows an error:**
   - If you encounter any unexpected errors, try restarting the script or your computer.
   - Make sure your computer is running Windows 10 or newer.

3. **Pi-Star Dashboard doesn’t open:**
   - Ensure your default web browser is set correctly in Windows.
   - Try manually entering the IP address into the browser’s address bar.

### Need more help?
If you need assistance or run into issues, feel free to create an **issue** in the GitHub repository or reach out to the community for help.

---

## Contributing

We welcome contributions from everyone! If you have suggestions or would like to improve this script, feel free to:
- Fork this repository.
- Make your changes.
- Submit a pull request.

---

Thank you for using **Pi-Star Network Scanner**! We hope this tool makes finding your Pi-Star device easier.
