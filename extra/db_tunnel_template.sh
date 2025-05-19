#!/bin/bash

set -e

# Load environment variables from .env if it exists
ENV_FILE="$(dirname "$0")/.env"

function gum_info() {
  gum style --foreground 212 "$@"
}

function gum_status() {
  gum style --foreground 214 --bold "$@"
}

function gum_success() {
  gum style --foreground 150 "$@"
}

function gum_error() {
  gum style --foreground 160 "$@"
}

function gum_input() {
  gum input --header="$1" --header.foreground="99" --placeholder "$2"
}

function gum_input_required() {
  local prompt="$1"
  local placeholder="$2"
  local value=""

  while [ -z "$value" ]; do
    value=$(gum_input "$prompt" "$placeholder")
    if [ -z "$value" ]; then
      gum_error "❌ Please provide a valid $prompt"
    fi
    gum_info "$value"
  done
}

function gum_choose() {
  local header="$1"
  shift
  gum choose --header "$header" --header.foreground="99" "$@"
}

function get_env() {
  if [ -f "$ENV_FILE" ]; then
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
}
get_env

# Initialize variables
STOP_MODE=false
START_MODE=false
STATUS_MODE=false
FORCE_STOP_MODE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  --stop)
    STOP_MODE=true
    shift
    ;;
  --force-stop)
    FORCE_STOP_MODE=true
    shift
    ;;
  --start)
    START_MODE=true
    shift
    ;;
  --status)
    STATUS_MODE=true
    shift
    ;;
  --ip)
    SERVER_IP="$2"
    shift 2
    ;;
  --user)
    SERVER_USER="$2"
    shift 2
    ;;
  --ports)
    PORTS="$2"
    shift 2
    ;;
  --remote)
    REMOTE_LOCAL="$2"
    shift 2
    ;;
  --action)
    ACTION_VAR="$2"
    shift 2
    ;;
  *)
    gum_error "Unknown option: $1"
    exit 1
    ;;
  esac
done

# Prompt for SERVER_USER if not set
if [ -z "$SERVER_USER" ]; then
  while [ -z "$SERVER_USER" ]; do
    SERVER_USER=$(gum_input "Enter server username" "root")
    if [ -z "$SERVER_USER" ]; then
      gum_error "❌ Invalid username. Please try again."
    fi
  done
fi

# Prompt for SERVER_IP if not set
if [ -z "$SERVER_IP" ]; then
  while [ -z "$SERVER_IP" ]; do
    SERVER_IP=$(gum_input "Enter server IP" "128.0.0.1")
    if [ -z "$SERVER_IP" ]; then
      gum_error "❌ Invalid ip. Please try again."
    fi
  done
fi

# Prompt for PORTS if not set
if [ -z "$PORTS" ]; then
  while [ -z "$PORTS" ]; do
    PORTS=$(gum_input "Enter port pairs (e.g., 5433:5432,3000:3000,9999:9999)" "5432:5432,3000:3000,9999:9999")
    if [ -z "$PORTS" ]; then
      gum_error "❌ Invalid port pairs. Please try again."
    fi
  done
fi

# Prompt for REMOTE_LOCAL if not set
if [ -z "$REMOTE_LOCAL" ]; then
  while [ -z "$REMOTE_LOCAL" ]; do
    REMOTE_LOCAL=$(gum_choose "Choose The REMOTE_LOCAL:" "localhost" "128.0.0.1" "0.0.0.0" "$SERVER_IP")
    if [ -z "$REMOTE_LOCAL" ]; then
      gum_error "❌ Invalid remote_local. Please try again."
    fi
  done
fi

# Convert comma-separated ports to an array
IFS=',' read -ra PORTS_ARRAY <<<"$PORTS"

if [ "$ACTION_VAR" ]; then
  case "$ACTION_VAR" in
  "start")
    ACTION="Start Tunnels"
    ;;
  "stop")
    ACTION="Stop Tunnels"
    ;;
  "status")
    ACTION="Status"
    ;;
  esac
fi

if $FORCE_STOP_MODE; then
  pkill -f "ssh -f -N -L" || true

  if [ $? -eq 0 ]; then
    gum_success "✅ All tunnels stopped."
  else
    gum_error "❌ Failed to stop all tunnels"
  fi

  exit 0
fi

if $STOP_MODE; then
  ACTION="Stop Tunnels"
fi

if $START_MODE; then
  ACTION="Start Tunnels"
fi

if $STATUS_MODE; then
  ACTION="Status"
fi

if [ -z "$ACTION" ]; then
  ACTION=$(gum_choose "Choose ACTION:" "Start Tunnels" "Stop Tunnels" "Status" "Exit")
fi

gum_info "$SERVER_USER:$SERVER_IP"
gum_info "PORTS: $PORTS"
gum_info "REMOTE_LOCAL: $REMOTE_LOCAL"
gum_info "ACTION: $ACTION"
printf "\n"

if [ "$ACTION" == "Exit" ]; then
  gum_info "Goodbye!"
  exit 1
fi

if [ "$ACTION" == "Status" ]; then
  gum_status "Tunnels:"

  for port_pair in "${PORTS_ARRAY[@]}"; do
    port_pair=${port_pair//\"/}
    LOCAL_PORT=${port_pair%%:*}
    REMOTE_PORT=${port_pair##*:}

    PROCESSES=$(ps -ef | grep "ssh -f -N -L $LOCAL_PORT:$REMOTE_LOCAL:$REMOTE_PORT" | grep -v grep | awk '{print $2}')

    if [ -n "$PROCESSES" ]; then
      gum_success "✅ Active: $LOCAL_PORT:$REMOTE_PORT"
    else
      gum_error "No active tunnel found for $LOCAL_PORT:$REMOTE_PORT"
    fi
  done
fi

if [ "$ACTION" == "Stop Tunnels" ]; then
  gum style --foreground 13 "Stopping Tunnels..."

  for port_pair in "${PORTS_ARRAY[@]}"; do
    port_pair=${port_pair//\"/}
    LOCAL_PORT=${port_pair%%:*}
    REMOTE_PORT=${port_pair##*:}

    # Find and print the matching processes
    PROCESSES=$(ps -ef | grep "ssh -f -N -L $LOCAL_PORT:$REMOTE_LOCAL:$REMOTE_PORT" | grep -v grep | awk '{print $2}')

    if [ -n "$PROCESSES" ]; then
      echo "$PROCESSES" | xargs kill -9
      gum_success "Stopped Tunnel: $LOCAL_PORT:$REMOTE_PORT"
    else
      gum_error "No active tunnel found for $LOCAL_PORT:$REMOTE_PORT"
    fi
  done
fi

if [ "$ACTION" == "Start Tunnels" ]; then
  for port_pair in "${PORTS_ARRAY[@]}"; do
    port_pair=${port_pair//\"/}
    LOCAL_PORT=${port_pair%%:*}
    REMOTE_PORT=${port_pair##*:}

    gum spin --spinner dot --show-error --title "Creating SSH tunnel for $LOCAL_PORT:$REMOTE_PORT..." -- \
      ssh -f -N -L "$LOCAL_PORT:$REMOTE_LOCAL:$REMOTE_PORT" "$SERVER_USER@$SERVER_IP" -o ServerAliveInterval=62 -o ServerAliveCountMax=3

    # && gum style --foreground 151 "Tunnel created for $LOCAL_PORT:$REMOTE_PORT"

    if [ $? -eq 0 ]; then
      gum_success "✅ Tunnel created for $LOCAL_PORT:$REMOTE_PORT"
    else
      gum_error "❌ Failed to create tunnel for $LOCAL_PORT:$REMOTE_PORT"
    fi
  done
fi
