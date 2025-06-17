FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y rsync openssh-client tailscale && \
    rm -rf /var/lib/apt/lists/*

CMD ["bash"]
