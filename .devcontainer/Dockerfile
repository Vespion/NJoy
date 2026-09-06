FROM ghcr.io/ansible/community-ansible-dev-tools:latest

# Elevate privileges to install system packages
USER root

RUN dnf -y install wget

RUN wget -O /etc/yum.repos.d/kanidm.repo https://download.opensuse.org/repositories/network:/idm/Fedora_$(rpm -E %fedora)/network:idm.repo

# Install Moby Engine and Docker Compose from Fedora's native repositories
RUN dnf -y install moby-engine docker-compose curl caddy kanidm-clients

RUN curl -fsSL https://www.earthbuild.dev/install.sh | sh

COPY <<EOF /etc/kanidm/config
uri = "https://idm.hoenn.me.uk"
EOF