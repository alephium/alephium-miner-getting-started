#!/usr/bin/env bash

echo "This script will setup docker, docker-compose and the required NVIDIA runtime"
echo "And reboot the server"

export DEBIAN_FRONTEND=noninteractive
export ENV TZ=UTC
sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common git jq openssh-server net-tools htop iftop iotop haveged fail2ban docker.io

# docker-compose version supporting gpus
wget https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64 && chmod +x docker-compose-Linux-x86_64 && sudo mv docker-compose-Linux-x86_64 /usr/bin/docker-compose

# Drivers and runtime nvidia
curl -s -L https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin | sudo tee /etc/apt/preferences.d/cuda-repository-pin-600
curl -s -L https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | sudo apt-key add -
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID); curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt update && sudo apt -y install cuda-drivers nvidia-container-runtime

sudo reboot
