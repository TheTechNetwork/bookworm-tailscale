#!/bin/bash

# Start tailscaled
tailscaled --state=/config/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
sleep 2

# Authenticate if needed (optional: only if not already connected)
# tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=rsync-seedbox

# Run passed CMD
exec "$@"
