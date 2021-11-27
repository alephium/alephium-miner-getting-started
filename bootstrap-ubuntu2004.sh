#!/usr/bin/env bash

which git || sudo apt install -y git

git clone https://github.com/touilleio/alephium-miner-setup.git
cd alephium-miner-setup

cat <<EOF | sudo tee /etc/motd
#
#

Welcome to this alephium miner. All the required files are in $HOME/alephium-miner-setup.
Everything automatically start at server boot / reboot.

# Get the logs of the miner
cd $HOME/alephium-miner-setup; docker-compose logs miner

Enjoy mining Alephium!

#
#
EOF

envsubst < alephium.service | sudo tee /etc/systemd/system/alephium.service
sudo systemctl daemon-reload
sudo systemctl enable alephium

./install-ubuntu2004.sh
