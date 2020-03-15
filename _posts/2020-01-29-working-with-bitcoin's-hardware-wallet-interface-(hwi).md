---
layout: post
title: Working with Bitcoin's Hardware Wallet Interface (HWI)
date: 29-01-2020 20:28:01
categories: ['bitcoin', 'code']
---

I listened to Andrew Chow on TFTC the other day and finally had some time to sit down and mess around with Bitcoin's HWI.

I struggled a bit to finally get the args correctly and this is what I came up with:

Get Master Pub Key
```
$ ./hwi.py -t keepkey -d "hid:IOService:/AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/XHC1@14/XHC1@14000000/HS01@14100000/KeepKey@14100000/IOUSBHostInterface@0/IOUSBHostHIDDevice@14100000,0" getmasterxpub

{"xpub": "xpub6BfcejXvhG5B6WyWEjWEt4mjGJ7Lf4A7o7uKBSoGhAYiZkqbuVfgTGfAdg5AmNuRjfioEpji9N3fwbSESnPJQfJhUXt7Qg5jPpWCPA6ztuV"}
```


get XPub Key
```
$ ./hwi.py -t keepkey -d "hid:IOService:/AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/XHC1@14/XHC1@14000000/HS01@14100000/KeepKey@14100000/IOUSBHostInterface@0/IOUSBHostHIDDevice@14100000,0" getxpub "44'/0'/1'/0/0"

{"xpub": "xpub6G5Xj9arGkLuhQ2k5eqMJZMvWsFgvPrzjfctd6nPVSVLChP9KEU35tnCk7g7byGygSEjrGLxMpEc2UqDB71uSRd7SWuG1yNCVrktXVXRmFR"}
```


Multisig addresses use `48'/0'/0'/2/0`