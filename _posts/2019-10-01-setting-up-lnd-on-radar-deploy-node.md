---
layout: post
title: Setting Up LND on RADAR Deploy Node
date: 01-10-2019 11:13:59
categories: ['bitcoin', 'code']
---
Instructions for setting up LND on a Radar Deploy Bitcoin node

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

### Download and Install LND
`mkdir /home/admin/downloads && cd /home/admin/downloads`

`wget https://github.com/lightningnetwork/lnd/releases/download/v0.7.1-beta/lnd-linux-amd64-v0.7.1-beta.tar.gz`

`tar -xzf lnd-linux-amd64-v0.7.1-beta.tar.gz`

`sudo install -m 0755 -o root -g root -t /usr/local/bin lnd-linux-amd64-v0.7.1-beta/*`

`lnd --version`

### Config LND
`mkdir /home/admin/.lnd`

`nano /home/admin/.lnd/lnd.conf`
```
# RaspiBolt: lnd configuration
# /home/bitcoin/.lnd/lnd.conf

[Application Options]
debuglevel=info
maxpendingchannels=5
alias=KayBeSee_Deploy
color=#68F442

# Your router must support and enable UPnP, otherwise delete this line  
# nat=true

tlsextradomain=bitcoinctest1569947199559-public-node.deploy-nodes-dev.radar.dev

rpclisten=0.0.0.0:10009

[Bitcoin]
bitcoin.active=1

# enable either testnet or mainnet
bitcoin.testnet=1
# bitcoin.mainnet=1

bitcoin.node=bitcoind

[autopilot]
autopilot.active=0
```

`lnd`

(NEW WINDOW)

### Create and fund wallet

`lncli --network=testnet create`

`lncli --network=testnet newaddress p2wkh`

Get testnet coins: [https://coinfaucet.eu/en/btc-testnet/](https://coinfaucet.eu/en/btc-testnet/){:target="_blank"}

### Connect to Radar Node

`lncli --network=testnet connect 03d5e17a3c213fe490e1b0c389f8cfcfcea08a29717d50a9f453735e0ab2a7c003@tbtc.ion.radar.tech:9735`

`lncli --network=testnet openchannel --node_key=03d5e17a3c213fe490e1b0c389f8cfcfcea08a29717d50a9f453735e0ab2a7c003 --local_amt=1000000`


### Connect to Zap
### Transfer TLS Cert and Admin Macaroon to local PC
`scp admin@bitcoinctest1570152557519-public-node.nodes.deploy.radar.tech:/home/admin/.lnd/tls.cert  lndTls.cert`

`scp admin@bitcoinctest1570152557519-public-node.nodes.deploy.radar.tech:/home/admin/.lnd/data/chain/bitcoin/testnet/admin.macaroon lndAdmin.macaroon`

