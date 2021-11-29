#!/usr/bin/env bash

echo "Welcome to the getting started guide to run Alephium miner"
echo "This process will install required packages and reboot the server"
echo "Hit Ctrl+C now if you don't want that."

sleep 3

which git || sudo apt install -y git

git clone https://github.com/touilleio/alephium-miner-setup.git $HOME/.alephium-miner-setup
cd $HOME/.alephium-miner-setup

cat <<EOF | sudo tee /etc/motd
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWWMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMWWWMMMMMMNOkxdoxXMMMMMMMMMMMMMM
MMMMMMMMMMMMMMNOoc:;,:OWMMMM0l::c:lKMMMMMMMMMMMMMM
MMMMMMMMMMMMMMNo.     'OWMMM0l::c:lKMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMNl.     ,0WMM0l:cc:lKMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMXc      ;xKM0l::::oKMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMK:      .:KKxddxk0NMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMK;       cKWWWMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMM0,      .lXMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMWO'      .oNMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMWk.      .dNMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMWX0OxdxKx.      .dWMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMO,.   .xWd.      .xWMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMk.    .xMNo'.     'kWMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMk.    .xMMNKo.     'OWMMMMMMMMMMMMMM
MMMMMMMMMMMMMMk.    .xMMMMXl.  ...oNMMMMMMMMMMMMMM
MMMMMMMMMMMMMMk.   .,OMMMMMNOxkOKXNMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMXxdxO0XWMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

Welcome to this alephium miner. All the required files are in $HOME/.alephium-miner-setup
Everything automatically start at server boot / reboot.

!! This is not a production-ready setup, use it at your own risk !!

# Get the logs of the miner:
cd $HOME/.alephium-miner-setup
docker-compose logs miner

Enjoy mining Alephium!

EOF

envsubst < alephium.service | sudo tee /etc/systemd/system/alephium.service
sudo systemctl daemon-reload
sudo systemctl enable alephium

./package-install-ubuntu2004.sh

echo "Install of the required components is now completed, rebooting to finish the setup."

sudo reboot
