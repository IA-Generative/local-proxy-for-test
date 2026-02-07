# Minimal Tinyproxy image with mandatory BasicAuth
FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends tinyproxy ca-certificates \
    && mkdir -p /var/log/tinyproxy \
    && chown -R tinyproxy:tinyproxy /var/log/tinyproxy \
    && rm -rf /var/lib/apt/lists/*

# Replace default config with our strict config
COPY tinyproxy/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

EXPOSE 3128

# Run tinyproxy in foreground so Docker can supervise it
CMD ["tinyproxy","-d","-c","/etc/tinyproxy/tinyproxy.conf"]
