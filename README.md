Getting started with Alephium Miner
====

This repository contains all the material needed to start [mining](https://wiki.alephium.org/GPU-Miner-Guide.html)
on [Alephium blockchain](https://alephium.org).

> ⚠️⚠️⚠️ Please keep in mind this is not a production setup, *use it at your own risks*!

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

# One step install

```shell
curl -L https://raw.githubusercontent.com/alephium/alephium-miner-getting-started/main/getting-started-ubuntu2004.sh | bash
```

## What's next?

Next you can edit the file `$HOME/.alephium-miner-setup/.env`, and particularly
configure an transfer address under the config parameter `miningTransferAddress`.
The mining companion will start transferring the mined ALPH to this wallet every 15 minutes.

Get involvement in the vibrant community in the [Alephium Discord server](https://discord.gg/JErgRBfRSB).

# Getting logs (FAQ)

For the miner:
```shell
cd $HOME/.alephium-miner-setup; docker-compose logs miner
```

To get mined blocks:
```shell
cd $HOME/.alephium-miner-setup; docker-compose logs miner | grep -i mined
```

For the broker:
```shell
cd $HOME/.alephium-miner-setup; docker-compose logs broker
```

To retrieve the mnemonic of your mining wallet:
```shell
cd $HOME/.alephium-miner-setup; docker-compose logs mining-companion | grep "SENSITIVE"
```

# What's going on under the hood?

At startup, a service called alephium is started (`/etc/systemd/system/alephium.service`). It will perform
the following operation, in sequence:

1. The init container creates the required directory structure with some permissive permissions.
2. The broker starts, connect to the `mainnet`, and start synching
3. The mining companion starts, and check is a mining wallet exists. If no, it creates one, printing the mnemonics in the logs (see below how to get the logs)
4. The mining companion configures the mining key of the broker
5. The miner waits (container restart) until the broker is synched with the chain, and starts mining.

And that's it, the whole process takes about 20 minutes at the time of writing.
