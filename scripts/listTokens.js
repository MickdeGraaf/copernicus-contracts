const { OpenSeaPort, Network } = require('opensea-js');

'use strict';

global.artifacts = artifacts;
global.web3 = web3;



// For truffle exec
module.exports = async function(callback) {
   console.log(web3.eth);

   const accounts = await web3.eth.getAccounts();
   const account = accounts[0];

   // This example provider won't let you make transactions, only read-only calls:
    const provider = web3.currentProvider;

    const seaport = new OpenSeaPort(provider, {
        networkName: Network.Rinkeby
    })

    // Expire this auction one day from now.
    // Note that we convert from the JavaScript timestamp (milliseconds):
    const expirationTime = Math.round(Date.now() / 1000 + 60 * 60 * 24)

    const auction = await seaport.createSellOrder({
    asset: {
        0,
        tokenAddress,
    },
    account,
    startAmount: 3,
    // If `endAmount` is specified, the order will decline in value to that amount until `expirationTime`. Otherwise, it's a fixed-price order:
    endAmount: 0.1,
    expirationTime
    })

   callback();
};