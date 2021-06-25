require('dotenv').config()

const HDWalletProvider = require('@truffle/hdwallet-provider');
const infuraKey = process.env.INFURA_KEY;
const mnemonic = process.env.MNEMONIC;

const kovanNodeUrl = "https://kovan.infura.io/v3/" + infuraKey;
console.log(infuraKey, mnemonic, kovanNodeUrl)
module.exports = {
  networks: {
    kovan: {
      provider: function () {
        return new HDWalletProvider(mnemonic, kovanNodeUrl);
      },
      gas: 5000000,
      skipDryRun: true,
      network_id: "*",
    },
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.6.12",    // Fetch exact version from solc-bin (default: truffle's version)
      settings: {          // See the solidity docs for advice about optimization and evmVersion
       optimizer: {
         enabled: false,
         runs: 200
       },
      }
    }
  }
};
