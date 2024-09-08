#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

echo -e "${CYAN}======================================================"
echo "Created by W8RJB ©2024 TechRay Apps LLC"
echo -e "${YELLOW}Disclaimer: Use this script at your own risk. We are not"
echo "responsible for any loss or damage caused by running"
echo "this script."
echo -e "======================================================${RESET}"

while true; do
    echo -e "${CYAN}Would you like to proceed? [Y/N]${RESET}"
    read -r user_choice
    case $user_choice in
        [Yy]* ) break;;
        [Nn]* ) echo -e "${RED}Exiting the script. Goodbye!${RESET}"; exit;;
        * ) echo -e "${RED}Invalid choice. Please enter Y to proceed or N to exit.${RESET}";;
    esac
done

echo -e "${CYAN}======================================================"
echo "Is your Pi-Star connected via Ethernet or Wi-Fi?"
echo "1. Ethernet"
echo "2. Wi-Fi"
echo -e "======================================================"
read -r connection_type

if [ "$connection_type" == "1" ]; then
    echo -e "${CYAN}======================================================"
    echo "Scanning for active Ethernet connections..."
    echo -e "======================================================${RESET}"

    ethernet_ips=$(ifconfig | grep -A 1 'eth' | grep 'inet ' | awk '{print $2}')

    if [ -z "$ethernet_ips" ]; then
        echo -e "${RED}No active Ethernet connections found.${RESET}"
        exit 1
    fi

    count=0
    echo -e "${YELLOW}Available Ethernet connections:${RESET}"
    for ip in $ethernet_ips; do
        count=$((count + 1))
        echo "$count. Ethernet: $ip"
        ethernet_array["$count"]=$ip
    done

    echo "Press the number corresponding to the Ethernet network your Pi-Star is connected to or press [I] for \"I don't know\":"
    read -r ethernet_choice

    if [[ "$ethernet_choice" =~ ^[Ii]$ ]]; then
        echo -e "${YELLOW}Scanning all Ethernet connections for Pi-Star...${RESET}"
        for ip in $ethernet_ips; do
            base_ip=$(echo "$ip" | cut -d"." -f1-3)
            for i in $(seq 1 254); do
                full_ip="$base_ip.$i"
                echo "Checking IP: $full_ip"
                ping -c 1 -W 1 "$full_ip" > /dev/null
                if [ $? -eq 0 ]; then
                    curl -s --connect-timeout 0.3 "http://$full_ip" | grep -iq "pi-star"
                    if [ $? -eq 0 ]; then
                        echo -e "${GREEN}Pi-Star found at IP address: $full_ip${RESET}"
                        xdg-open "http://$full_ip"
                        exit 0
                    fi
                fi
            done
        done
    else
        selected_ip=${ethernet_array["$ethernet_choice"]}
        base_ip=$(echo "$selected_ip" | cut -d"." -f1-3)
        echo -e "${YELLOW}Scanning the selected Ethernet network: $selected_ip...${RESET}"
        for i in $(seq 1 254); do
            full_ip="$base_ip.$i"
            echo "Checking IP: $full_ip"
            ping -c 1 -W 1 "$full_ip" > /dev/null
            if [ $? -eq 0 ]; then
                curl -s --connect-timeout 0.3 "http://$full_ip" | grep -iq "pi-star"
                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}Pi-Star found at IP address: $full_ip${RESET}"
                    xdg-open "http://$full_ip"
                    exit 0
                fi
            fi
        done
    fi

elif [ "$connection_type" == "2" ]; then
    echo -e "${CYAN}======================================================"
    echo "Scanning Wi-Fi network range for Pi-Star..."
    echo -e "======================================================${RESET}"

    wifi_ip=$(ifconfig | grep -A 1 'wlan' | grep 'inet ' | awk '{print $2}')

    if [ -z "$wifi_ip" ]; then
        echo -e "${RED}Could not find an active Wi-Fi connection.${RESET}"
        exit 1
    fi

    base_ip=$(echo "$wifi_ip" | cut -d"." -f1-3)
    echo -e "${YELLOW}Scanning Wi-Fi network range $base_ip.x for Pi-Star...${RESET}"

    for i in $(seq 1 254); do
        full_ip="$base_ip.$i"
        echo "Checking IP: $full_ip"
        ping -c 1 -W 1 "$full_ip" > /dev/null
        if [ $? -eq 0 ]; then
            curl -s --connect-timeout 0.3 "http://$full_ip" | grep -iq "pi-star"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Pi-Star found at IP address: $full_ip${RESET}"
                xdg-open "http://$full_ip"
                exit 0
            fi
        fi
    done

else
    echo -e "${RED}Invalid choice. Please enter 1 for Ethernet or 2 for Wi-Fi.${RESET}"
    exit 1
fi

echo -e "${RED}No Pi-Star device was found.${RESET}"
exit 1
