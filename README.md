<p align="center">
  <a href="http://inka.finance/" target="blank"><img src="./2.svg" width="200" alt="Inka Logo" /></a>
</p>
<p align="center">The most friendly DeFi wallet and multichain platform.</p>

## Table of contents

- [Description](#description)
- [How it works](#how-it-works)
- [Built With](#built-with)
- [How to run](#how-to-run)
- [Future Updates](#future-updates)
- [Author](#author)
- [Support](#support)

## Description

Aave is an open-source, non-custodial liquidity protocol for earning interest on deposits and borrowing assets. Inka wallet integrates with the Aave service through smart contracts in the Solidity language, which allows you to have easy access to add liquidity to the service.

<p>A smart contract for using the Aave service takes a commission that is charged to the Inka wallet.</p>

## How it works

<p align="center">
<img src="./inka_dig.png" alt="Inka diagrams" />
</p>

<p>Smart contract InkaAaveProvder is a special layer for integration with the Aave service. This layer provides easier access to perform operations on the service.</p>

## Built With

- NodeJS
- Truffle.js
- Web3.js

## How to run

When developing a smart contract, the Truffle framework was used to start the deployment process, you need to set up environment variables and install the necessary libraries

<p>ENVIRONMENT variables:</p>

* INFURA_KEY
* MNEMONIC

```
$ npm install

$ truffle compile

$ truffle migrate --network kovan
```

## Future Updates

- [x] Deposit ETH
- [x] Deposit ERC20

## Author

- [Profile](https://github.com/Inka-Finance "Inka Finance Development Team")
- [Email](mailto:a.zhaxybayev@inka.finance?subject=Hi "Hi!")
- [WebSite](https://inka.finance/ "Welcome")

## 🤝 Support

Contributions, issues, and feature requests are welcome!

Give a ⭐️ if you like this project!
