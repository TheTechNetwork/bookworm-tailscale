FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl gnupg2 ca-certificates \
        iputils-ping \
        rsync \
        openssh-client && \
    curl -fsSL https://tailscale.com/install.sh | sh && \
    rm -rf /var/lib/apt/lists/*

CMD ["bash"]
