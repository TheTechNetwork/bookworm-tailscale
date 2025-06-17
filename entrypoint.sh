#!/bin/bash

# Start tailscaled in background
echo "🌀 Starting tailscaled..."
/usr/sbin/tailscaled --state=/config/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
TAILSCALE_PID=$!

# Wait for tailscaled to start
sleep 3

# Optional: Bring up the interface if not already done
if ! tailscale status >/dev/null 2>&1; then
  echo "🔐 Bringing up Tailscale interface..."
  tailscale up --hostname="${TAILSCALE_HOSTNAME:-rsync-seedbox}" --state=/config/tailscaled.state
fi

# Trap container exit and clean up tailscaled
trap "echo '🛑 Stopping tailscaled...'; kill $TAILSCALE_PID" SIGINT SIGTERM

# Run passed CMD
echo "🚀 Running command: $@"
exec "$@"
