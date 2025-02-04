# Use the official Ubuntu Noble base image
FROM ubuntu:noble

# Set environment variables for non-interactive apt and prevent cache bloating
ENV DEBIAN_FRONTEND=noninteractive \
  TZ=Etc/UTC \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8

# Update packages, install dependencies, and set up Node.js (v22) and Docker cli
RUN apt-get update && apt-get install -y ca-certificates curl && \
  install -m 0755 -d /etc/apt/keyrings && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
  chmod a+r /etc/apt/keyrings/docker.asc && \
  # Add the repository to Apt sources:
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  # Update the package cache and install Docker CLI
  apt-get update && apt-get install -y docker-ce-cli && \
  apt-get update && apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
  build-essential \
  wget \
  git \
  sudo \
  openssh-client \
  tzdata && \
  # Install Node.js v22 (using Nodesource)
  curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
  apt-get install -y nodejs && \
  # Verify Node.js and npm installations
  node -v && npm -v && \
  # Clean up package cache to reduce image size
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Playwright globally along with its dependencies & Install Appium for mobile testing
RUN npm install -g playwright

# Create a non-root user with sudo privileges
ARG USERNAME=ubuntu

RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
  chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to the non-root user
USER $USERNAME

# Set the working directory
WORKDIR /home/$USERNAME

# Install Playwright system dependencies
RUN npx playwright install-deps && \
  # Install Playwright browsers
  npx playwright install && \
  # Verify Playwright installation
  npx playwright --version

# Default shell for the user
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["bash"]
