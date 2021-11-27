Alephium Miner Setup
====

This repository contains all the material needed to start [mining](https://wiki.alephium.org/GPU-Miner-Guide.html)
on [Alephium blockchain](https://alephium.org). But it is not a production setup, *use it at your own risks*!

It is based on [docker](https://www.docker.com/), [docker-compose](https://docs.docker.com/compose/) and [ubuntu linux version 20.04](https://ubuntu.com/),
and works out of the box with this setup.

The setup contains multiple parts, a.k.a:

- the [broker](https://github.com/alephium/alephium), Alephium full node, storing the blockchain and communicating with other nodes
- the [miner](https://github.com/alephium/gpu-miner), Alephium miner, securing the chain
- the [mining-companion](https://github.com/touilleio/alephium-mining-companion), performing coordination duty between the miner and the broker
- the init module, to initialise some directory structures
- [prometheus](), a timeserie datastore because metrics are king
- [mtail](), to collect miner metrics
- [grafana](), a metrics visualisation tool, because metrics are king :)



# Use it

## One step install

```shell
curl -L https://raw.githubusercontent.com/touilleio/alephium-miner-setup/main/bootstrap-ubuntu2004.sh | bash
```

## More detailed steps

The following steps are best run as root: `sudo su -`

## Clone the repo

```shell
git clone https://github.com/touilleio/alephium-miner-setup.git
cd alephium-miner-setup
```

## Run the install script

This script will install the required components as well as the Nvidia drivers.
The script will also *REBOOT* the node, so make sure nothing important can be lost during the reboot.

```shell
./install-ubuntu-2004.sh
```

## Run!

The whole stack can be started via docker-compose, such as:
```shell
docker-compose up -d
```

## What's going on?

1. The init container creates the required directory structure with some permissive permissions.
2. The broker starts, connect to the mainnet, and start synching
3. The mining companion starts, and check is a mining wallet exists. If no, it creates one, printing the mnemonics in the logs (see below how to get the logs)
4. The mining companion configures the mining key of the broker
5. The miner waits (container restart) until the broker is synched with the chain, and starts mining.

And that's it, the whole process takes about 20 minutes at the time of writing.

## Getting logs

To browse logs of the miner, use again docker-compose from the `alephium-miner-setup` folder
```shell
docker-compose logs -f miner
```

For the logs of the `broker`, replace `miner` with `broker`. For `mining-companion`,
replace `miner` with `mining-companion`.
And so on.
