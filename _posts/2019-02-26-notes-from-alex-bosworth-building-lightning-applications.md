---
layout: post
title: Notes from Alex Bosworth Building Lightning Applications
date: 26-02-2019 11:30:11
categories: ['bitcoin']
---
Here are some notes I took from Alex Bosworth's Building Lightning Applications talk. 

You can find the video on YouTube [here]((https://www.youtube.com/watch?v=JhRIWc9zPjA)«).

To communicate with LND, use a gRPC.

Pros:
    - small data
    - streaming

Cons:
    - not supported on all platforms (like REST)

Run LND in the background and provide functionality for your app

Future:
- Move towards a library system, not protocol system

### Chain Backends
- Bitcoin Core recommended (btcd is useful for testing)
- Neutrino in the works

### Chain Wallet
When spinning up lightning you are actually creating two wallets. One wallet for the chain and another wallet for your channels.

Because of HTLCs and Time Locks, LND tries to give you a good view of your channels states and balance states but Alex seems to think there is some improvements there to be made just based off the hesitant way he saids it.

Recommends limiting the min-channel-size. We don't want people to make a bunch of tiny channels to individuals, we want big channels that are connected so that we can _use_ the network effects of lightning to route payments.

Alex doesn't recommend using the autopilot feature in LND (he saids its a stub function). Instead, you should look at the graph and manually open channels with stable nodes.

He mentions node operators sending out "heartbeats" every week or so and re-evaluating their channels. I wish he went into a little more depth about what a heartbeat is.

Payment Request - Bolt11 Format (includes routing hints, description of payment)
Payment Invoice - Local version of payment request. 
 - Payment request is generated from invoice. 
 - Includes information you wouldn't include in request like the preimage

Q: What is a pre=image in LND context?

### Processing Receives
 - Listen to the invoice subscription
 - Your application should be able to tell the user that their payment was accepted even before the user's interface will (like on the wallet they're using to send the payment). This is because the payment success notification has to route back to their interface which can take a second or two.
 - LND is not made to be a payment processing system (use BTC Payserver)
 - Up until you get HTLC lock view you never want to show anyone that preimage. Generate random preimage or let LND do it for you.
 - Once you get HTCL lock view, then you want to spray that preimage everywhere. You want to get it to the user as fast as possible so that they know that they paid.

### Sending Payments
  - Query routes with local graph to see if sending a payment is even possible. You can do this without actually sending a payment.
  - Allows to send custom routes that can reward friends with routing fees.
  - LND also supports on-chain sends (with SegWit too!)

### Balance
- More complicated than regular bitcoin balance because there isn't just `confirmed` and `pending` balances

In lnd you have more types of balances
- Sweeps: HTLCs that you own but need to wait to send
- Timelocked
- Balance in Limbo
- Pending Resolution - it might refund or it might go through
- Channel Balances - reserve, minus commit fees
- Not including 1% balance for game theory closing, From my understanding, you always want to have some balance within the channel because if there is no balance then you can maliciously close the channel to try to get funds since you have no incentive to close it legitimately because you're not going to get any money back either way.

### The Graph
Everyone sees everyone with public channels. Ideally we want to have all nodes be private except for routing nodes.

Displays nodes and displays channels.

Some channels have limits on HTLC length, minimum amount that they'll route, their routing fee receiving and their routing fee sending.

### Wallet Security
Hot Wallet fails when shutdown. Doesn't keep track of channel balance, etc. I need to do more research on how this actually works. I understand it a bit but I also don't understand why you can't just store the channel balances in a file as the balances change.

Macaroons can be super customized so that you can give permission to send anywhere, send to certain addresses, only generate invoices (no sending of funds), etc.

Keep your node online

### Reliability
No way formal way right now to restore versions if your node malfunctions. So keep funds on your node limited.

Right now, best way would be to RAID and distribute database across multiple disks.

Static backups coming soon.