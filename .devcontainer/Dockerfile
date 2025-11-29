FROM mcr.microsoft.com/devcontainers/base:jammy

# Basic tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      curl \
      unzip \
      gnupg \
      ca-certificates \
      apt-transport-https && \
    rm -rf /var/lib/apt/lists/*

# ---------- Terraform ----------
ARG TERRAFORM_VERSION=1.9.8
RUN curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
      -o terraform.zip \
 && unzip terraform.zip \
 && mv terraform /usr/local/bin/terraform \
 && rm terraform.zip

# ---------- Google Cloud CLI ----------
RUN mkdir -p /usr/share/keyrings && \
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
      | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
      > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y google-cloud-cli && \
    rm -rf /var/lib/apt/lists/*
