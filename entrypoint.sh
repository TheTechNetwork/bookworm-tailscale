#!/bin/bash

echo "🌀 Starting tailscaled..."
# Start tailscaled in background with state saved to /config
tailscaled --state=/config/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &

# Wait for tailscaled to be ready
sleep 3

# Only run tailscale up if not already logged in
if ! tailscale status &>/dev/null; then
  echo "🔐 Running tailscale up..."
  tailscale up --hostname="${TAILSCALE_HOSTNAME:-rsync-seedbox}" --reset
fi

# Execute the container's main command
exec "$@"
