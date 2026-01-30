# Pterodactyl Image created by vanes430
FROM debian:bookworm-slim

ARG JAVA_VERSION=17

LABEL author="vanes430" maintainer="admin@vanes430.my.id"
LABEL org.opencontainers.image.source="https://github.com/arqonarateam/arqonara-java"
LABEL org.opencontainers.image.licenses="GPLv3"
LABEL org.opencontainers.image.description="Java 17 (Azul Zulu) image for Pterodactyl"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl jq ca-certificates openssl passwd locales iproute2 tar && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN set -e; \
    URL=$(curl -fsSL "https://api.azul.com/zulu/download/community/v1.0/bundles/latest/?java_version=17&os=linux&arch=x86&hw_bitness=64&bundle_type=jdk&ext=tar.gz" | jq -r ".url"); \
    if [ -z "$URL" ] || [ "$URL" = "null" ]; then echo "Error: Failed to fetch download URL"; exit 1; fi; \
    echo "Downloading Java from $URL"; \
    curl -fL -o /tmp/zulu.tar.gz "${URL}" && \
    mkdir -p /opt/java/zulu && \
    tar -xzf /tmp/zulu.tar.gz -C /opt/java/zulu --strip-components=1 --no-same-owner --no-same-permissions --no-xattrs --no-selinux --no-acl && \
    chmod -R +rX /opt/java && \
    rm /tmp/zulu.tar.gz

RUN curl -L -o /usr/local/bin/entrypoint https://github.com/arqonarateam/arqonara-java/releases/download/release/entrypoint && \
    chmod +x /usr/local/bin/entrypoint

RUN useradd -m -d /home/container container

ENV JAVA_HOME=/opt/java/zulu
ENV PATH="/opt/java/zulu/bin:${PATH}"
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]