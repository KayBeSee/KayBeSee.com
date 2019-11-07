---
layout: post
title: Setting Up C-Lightning on RADAR Deploy Node
date: 06-11-2019 15:33:43
categories: ['bitcoin', 'code']
---
Instructions for setting up C-Lightning on a Radar Deploy Bitcoin node

### Create Deploy Node

### Get SSH Credentials

### SSH Into Box

`mkdir /home/admin/.bitcoin`

`nano /home/admin/.bitcoin/bitcoin.conf`

```
# RaspiBolt: bitcoind configuration
# /home/bitcoin/.bitcoin/bitcoin.conf

# remove the following line to enable Bitcoin mainnet
testnet=1

# Bitcoind options
server=1
daemon=1

# Connection settings
rpcuser=rpcuser
rpcpassword=rpcpass

onlynet=ipv4
zmqpubrawblock=tcp://127.0.0.1:28332
zmqpubrawtx=tcp://127.0.0.1:28333

# Raspberry Pi optimizations
dbcache=100
maxorphantx=10
maxmempool=50
maxconnections=40
maxuploadtarget=5000
```

### Download and Install C-Lightning

Get dependencies:
```
sudo apt-get update
sudo apt-get install -y \
  autoconf automake build-essential git libtool libgmp-dev \
  libsqlite3-dev python python3 python3-mako net-tools zlib1g-dev libsodium-dev \
  git gettext
```

Clone lightning:
```
git clone https://github.com/ElementsProject/lightning.git
cd lightning
```

Build lightning:
```
./configure
make
sudo make install
```

Run lightning:
```
./lightningd/lightningd
```

In another terminal window, use the `lightning-cli` to run commands
```
./cli/lightning-cli help
```

### Fund Wallet and Connect to Peers
Fund wallet via https://coinfaucet.eu/en/btc-testnet/

```
./cli/lightning-cli newaddr
```

Connect to Peers
```
./cli/lightning-cli connect 03d5e17a3c213fe490e1b0c389f8cfcfcea08a29717d50a9f453735e0ab2a7c003@3.16.119.191:9735
./cli/lightning-cli fundchannel [channelId] [fundingAmountSats]
```

### Send Payment

```
./cli/lightning-cli pay [bolt11_invoice]
```