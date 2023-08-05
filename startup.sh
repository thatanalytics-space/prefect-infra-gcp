#!/bin/bash

export PREFECT_API_KEY="your_prefect_api_key_here"

export PATH="$HOME/.local/bin:$PATH"

# Update and install necessary packages
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    python3-dateutil \
    tmux

sudo apt-get install -y python3
sudo apt-get install -y python3-pip

# Install Python packages
pip install prefect prefect-gcp gcsfs

# Login to Prefect Cloud
prefect cloud login --key $PREFECT_API_KEY --workspace usamabt94gmailcom/prod
