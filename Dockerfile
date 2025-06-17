FROM tailscale/tailscale:latest

# Install useful tools
RUN apt-get update && apt-get install -y \
    rsync \
    openssh-client \
    iputils-ping \
    curl \
    bash \
 && rm -rf /var/lib/apt/lists/*

# Universal entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
