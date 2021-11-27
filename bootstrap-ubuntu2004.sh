#!/usr/bin/env bash

which git || sudo apt install -y git

git clone https://github.com/touilleio/alephium-miner-setup.git
cd alephium-miner-setup

cat <<EOF | sudo tee /etc/motd
#
#

Welcome to this alephium miner. All the required files are in $HOME/alephium-miner-setup.

# Get the logs of the miner
cd $HOME/alephium-miner-setup; docker-compose logs miner

Enjoy mining Alephium!

#
#
EOF


sudo ./install-ubuntu2004.sh

