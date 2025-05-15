#!/bin/bash

# Download the script from GitHub
curl -o ~/aztec_ip_monitor.sh https://raw.githubusercontent.com/IrizHere/Aztect-WSL-IP-Update-Script/main/aztec_ip_monitor.sh

# Ask the user for their config values
read -p "Enter your L1 RPC URL: " L1_RPC
read -p "Enter your L1 Beacon (Consensus) RPC URL: " L1_BEACON_RPC
read -p "Enter your Validator Private Key: " PRIVATE_KEY
read -p "Enter your Public Key (Coinbase Address): " PUBLIC_KEY

# Replace placeholders in the script
sed -i "s|<YOUR_L1_RPC_URL>|$L1_RPC|g" ~/aztec_ip_monitor.sh
sed -i "s|<YOUR_L1_BEACON_RPC_URL>|$L1_BEACON_RPC|g" ~/aztec_ip_monitor.sh
sed -i "s|<YOUR_PRIVATE_KEY>|$PRIVATE_KEY|g" ~/aztec_ip_monitor.sh
sed -i "s|<YOUR_COINBASE_ADDRESS>|$PUBLIC_KEY|g" ~/aztec_ip_monitor.sh

# Make the script executable
chmod +x ~/aztec_ip_monitor.sh

# Run the script
echo "Starting the Aztec IP Monitor script..."
~/aztec_ip_monitor.sh
