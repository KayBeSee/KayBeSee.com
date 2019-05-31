---
layout: post
title: Commands for LNDConnect
date: 11-03-2019 06:15:48
categories: [code, bitcoin]
---
I had been messing around with my RaspberryPi to get my Zap wallet connected with my phone. A lot of it involved configuring the TLS.cert file to accept the right IP addresses, and so I used these commands a lot:

```
// Remove all old certs and macaroons
rm -rf /mnt/hdd/lnd/tls.cert &&
rm -rf /mnt/hdd/lnd/tls.key  &&
rm -rf /mnt/hdd/lnd/data/chain/bitcoin/mainnet/admin.macaroon &&
rm -rf /mnt/hdd/lnd/data/chain/bitcoin/mainnet/invoice.macaroon &&
rm -rf /mnt/hdd/lnd/data/chain/bitcoin/mainnet/macaroons.db &&
rm -rf /mnt/hdd/lnd/data/chain/bitcoin/mainnet/readonly.macaroon
```

```
// copy tls cert and macaroons to local machine
// TODO: ADD CD GOPATH COMMAND
scp bitcoin@192.168.200.20:/mnt/hdd/lnd/tls.cert ./ &&
scp bitcoin@192.168.200.20:/mnt/hdd/lnd/data/chain/bitcoin/mainnet/admin.macaroon ./
```

```
// LND command
lndconnect --host=kaybesee.com --tlscertpath=/Users/kevinmulcrone/gocode/src/github.com/LN-Zap/lndconnect/tls.cert --adminmacaroonpath=/Users/kevinmulcrone/gocode/src/github.com/LN-Zap/lndconnect/admin.macaroon
// alt
lndconnect --host=192.168.200.20 --tlscertpath=/Users/kevinmulcrone/gocode/src/github.com/LN-Zap/lndconnect/tls.cert --adminmacaroonpath=/Users/kevinmulcrone/gocode/src/github.com/LN-Zap/lndconnect/admin.macaroon
```

```
open firewall
ufw allow 10009 comment 'zap'
```