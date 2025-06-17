#!/bin/bash
set -e

echo "🌀 Starting tailscaled..."
/usr/sbin/tailscaled --state="${TAILSCALE_STATE_DIR:-/config}/tailscaled.state" --socket=/var/run/tailscale/tailscaled.sock &
sleep 3

echo "🔐 Logging into Tailscale..."
tailscale up --hostname="${TAILSCALE_HOSTNAME:-universal-box}" --reset

echo "⏳ Waiting for Tailscale to be ready..."
for i in {1..10}; do
  if tailscale status &>/dev/null; then
    echo "✅ Tailscale is up."
    break
  fi
  sleep 2
done

echo "🚀 Running command: $@"
exec "$@"
