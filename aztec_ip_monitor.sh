#!/bin/bash

# File to store current IP and IP change history
IP_LOG_FILE="$HOME/aztec_ip_history.log"

# Store the initial IP address
CURRENT_IP=""

# Your node startup command (use your actual values)
BASE_CMD="aztec start --node --archiver --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls <YOUR_L1_RPC_URL> \
  --l1-consensus-host-urls <YOUR_L1_BEACON_RPC_URL> \
  --sequencer.validatorPrivateKey <YOUR_PRIVATE_KEY> \
  --sequencer.coinbase <YOUR_COINBASE_ADDRESS> \
  --p2p.maxTxPoolSize 1000000000"

while true; do
  NEW_IP=$(curl -s ipv4.icanhazip.com)

  if [ "$CURRENT_IP" != "$NEW_IP" ]; then
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$TIMESTAMP: IP changed to $NEW_IP" | tee -a "$IP_LOG_FILE"

    pkill -f "aztec start"
    $BASE_CMD --p2p.p2pIp "$NEW_IP" &

    CURRENT_IP="$NEW_IP"
  else
    echo "$(date): IP unchanged ($CURRENT_IP)."
  fi

  sleep 120
done
