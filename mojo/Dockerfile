FROM ubuntu:22.04
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    git \
    curl \
    python3 \
    build-essential \
    libedit-dev \
    apt-transport-https \
    gpg \
    ca-certificates \
 && curl -1sLf 'https://dl.modular.com/bBNWiLZX5igwHXeu/installer/gpg.0E4925737A3895AD.key' \
    | gpg --dearmor >> /usr/share/keyrings/modular-installer-archive-keyring.gpg \
 && curl -1sLf \
        'https://dl.modular.com/bBNWiLZX5igwHXeu/installer/config.deb.txt?distro=debian&codename=wheezy' \
    > /etc/apt/sources.list.d/modular-installer.list \
 && apt-get -y update \
 && apt-get install -y modular \
 && python3 -m venv /mojo-venv \
 && . /mojo-venv/bin/activate \
 && modular install mojo \
 && rm -rf /tmp/* /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"] 
