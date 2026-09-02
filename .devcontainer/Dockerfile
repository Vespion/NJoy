FROM ghcr.io/ansible/community-ansible-dev-tools:latest

# Elevate privileges to install system packages
USER root

# Install Moby Engine and Docker Compose from Fedora's native repositories
RUN dnf -y install moby-engine docker-compose curl \
    && dnf clean all

RUN curl -fsSL https://www.earthbuild.dev/install.sh | sh