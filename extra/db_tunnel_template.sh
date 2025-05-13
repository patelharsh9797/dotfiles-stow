#!/bin/bash

# Load environment variables from .env if it exists
ENV_FILE="$(dirname "$0")/.env"
PORTS=()
REMOTE_LOCAL=0.0.0.0

if [ -f "$ENV_FILE" ]; then
  echo "Loading environment variables from $ENV_FILE"
  while IFS= read -r line; do
    # Skip empty lines and comments
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue

    # Handle PORTS separately
    if [[ "$line" == PORTS=* ]]; then
      PORTS+=("${line#PORTS=}")
    else
      # Export other environment variables
      export "$line"
    fi
  done <"$ENV_FILE"
fi

# Check if IP and user are set
SERVER_IP=${SERVER_IP:-"missing_ip"}
SERVER_USER=${SERVER_USER:-"missing_user"}

if [ "$SERVER_IP" == "missing_ip" ]; then
  echo "Error: SERVER_IP is not set. Please export it, use a .env file, or pass it as an argument."
  exit 1
fi

if [ "$SERVER_USER" == "missing_user" ]; then
  echo "Error: SERVER_USER is not set. Please export it, use a .env file, or pass it as an argument."
  exit 1
fi

# Handle stopping the tunnel
if [ "$1" == "--stop" ]; then
  echo "Stopping all active tunnels..."

  for port_pair in "${PORTS[@]}"; do
    LOCAL_PORT=$(echo "$port_pair" | cut -d: -f1 | tr -d '"')
    REMOTE_PORT=$(echo "$port_pair" | cut -d: -f2 | tr -d '"')

    # echo "Stopping tunnel on port $LOCAL_PORT..."

    # Find and print the matching processes
    PROCESSES=$(ps aux | grep "ssh -f -N -L $LOCAL_PORT:$REMOTE_LOCAL:$REMOTE_PORT" | grep -v grep)

    if [ -n "$PROCESSES" ]; then
      PIDS=$(ps -ef | grep "ssh -f -N -L $LOCAL_PORT:$REMOTE_LOCAL:$REMOTE_PORT" | grep -v grep | awk '{print $2}')

      # Extract the process IDs and kill them
      echo "$PIDS" | xargs kill -9

      echo "$PIDS Tunnel stopped for $LOCAL_PORT:$REMOTE_PORT."
    else
      echo "No active tunnel found on port $LOCAL_PORT."
    fi

    # echo "Stopping tunnel on port $LOCAL_PORT..."
    # pkill -f "ssh -f -N -L $LOCAL_PORT"
  done

  exit 0
fi

# Create tunnels for all port pairs
echo "Creating SSH tunnels to $SERVER_IP..."

for port_pair in "${PORTS[@]}"; do
  # Remove any surrounding quotes
  port_pair=$(echo "$port_pair" | tr -d '"')

  LOCAL_PORT=$(echo "$port_pair" | cut -d: -f1)
  REMOTE_PORT=$(echo "$port_pair" | cut -d: -f2)

  echo "Creating tunnel for $LOCAL_PORT:$REMOTE_PORT..."
  ssh -f -N -L $LOCAL_PORT:$REMOTE_LOCAL:$REMOTE_PORT $SERVER_USER@$SERVER_IP -o ServerAliveInterval=61 -o ServerAliveCountMax=3
done

echo "All tunnels created successfully."

pgrep -af "ssh -f -N -L"
