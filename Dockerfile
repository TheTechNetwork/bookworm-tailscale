FROM tailscale/tailscale:latest

# Install rsync, ping, ssh client, bash in Alpine
RUN apk add --no-cache \
    rsync \
    iputils \
    openssh-client \
    bash \
    curl

# Copy and use universal entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
