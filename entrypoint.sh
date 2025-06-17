#!/bin/bash
set -e

echo "🌀 Starting tailscaled..."
/usr/sbin/tailscaled --state=/config/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
TAILSCALE_PID=$!

sleep 3

# Run `tailscale up` only if needed
if ! /usr/bin/tailscale status >/dev/null 2>&1; then
  echo "🔐 Running tailscale up..."
  /usr/bin/tailscale up --hostname="${TAILSCALE_HOSTNAME:-rsync-seedbox}" --state=/config/tailscaled.state
fi

trap "echo '🛑 Stopping tailscaled...'; kill $TAILSCALE_PID" SIGINT SIGTERM

echo "🚀 Running command: $@"
exec "$@"
