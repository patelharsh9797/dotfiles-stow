#!/bin/bash

# Load environment variables from .env if it exists
ENV_FILE="$(dirname "$0")/.env"
if [ -f "$ENV_FILE" ]; then
  echo "Loading environment variables from $ENV_FILE"
  while IFS= read -r line; do
    # Skip empty lines and comments
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
    # Export the variable
    export "$line"
    # Print the variable (safe to print as long as it doesn't contain secrets)
    # echo "Loaded: $line"
  done <"$ENV_FILE"
fi

# Handle stopping the tunnel
if [ "$1" == "--stop" ]; then
  echo "Stopping tunnel on port $LOCAL_PORT..."

  # Find and print the matching processes
  PROCESSES=$(pgrep -af "ssh -f -N -L $LOCAL_PORT:localhost:$REMOTE_PORT")

  if [ -n "$PROCESSES" ]; then
    echo "Killing the following processes:"
    echo "$PROCESSES"
    # Kill the processes
    echo "$PROCESSES" | awk '{print $1}' | xargs kill
    echo "Tunnel stopped."
  else
    echo "No active tunnel found on port $LOCAL_PORT."
  fi

  exit 0
fi

# Check if IP is set
SERVER_IP=${SERVER_IP:-"missing_ip"}

echo SERVER_IP=$SERVER_IP

if [ "$SERVER_IP" == "missing_ip" ]; then
  echo "Error: SERVER_IP is not set. Please export it, use a .env file, or pass it as an argument."
  exit 1
fi

# Set your VPS username
USERNAME=${SERVER_USER:-"missing_user"}

echo USERNAME=$USERNAME

if [ "$USERNAME" == "missing_user" ]; then
  echo "Error: SERVER_IP is not set. Please export it, use a .env file, or pass it as an argument."
  exit 1
fi

#Set the local and remote ports
# LOCAL_PORT=$LOCAL_PORT
# REMOTE_PORT=$REMOTE_PORT

echo LOCAL_PORT:REMOTE_PORT=$LOCAL_PORT:$REMOTE_PORT

# Create the tunnel
echo "Creating SSH tunnel to $SERVER_IP..."

ssh -f -N -L $LOCAL_PORT:localhost:$REMOTE_PORT $USERNAME@$SERVER_IP -o ServerAliveInterval=60 -o ServerAliveCountMax=3

echo "Tunnel created. You can now connect to your database at localhost:$LOCAL_PORT"
