require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");

/** @type import('hardhat/config').HardhatUserConfig */
require("dotenv").config();

const MAINNET_PRIVATE_KEY = process.env.MAINNET_PRIVATE_KEY;
const TESTNET_PRIVATE_KEY = process.env.TESTNET_PRIVATE_KEY;
const BSC_API_KEY = process.env.BSCSCAN_API_KEY;
module.exports = {
  solidity: {
    version: "0.8.15",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://bscscan.com/
    apiKey: process.env.BSCSCAN_API_KEY,
  },

  defaultNetwork: "bsc",
  // defaultNetwork: "hardhat",
  networks: {
    hardhat: {},
    bsc: {
      url: "https://bsc-dataseed.binance.org/",
      chainId: 56,
      accounts: [MAINNET_PRIVATE_KEY],
      gas: "auto",
      gasPrice: 5000000000,
    },
    // bsctestnet: {
    //   url: "https://data-seed-prebsc-1-s1.binance.org:8545/",
    //   chainId: 97,
    //   accounts: [""],
    //   gas: "auto",
    //   gasPrice: 10000000000,
    // },
    // polygon: {
    //   url: "https://rpc-mainnet.maticvigil.com",
    //   chainId: 137,
    //   accounts: [MAINNET_PRIVATE_KEY],
    // },
    // mumbai: {
    //   url: "https://matic-mumbai.chainstacklabs.com",
    //   chainId: 80001,
    //   accounts: [TESTNET_PRIVATE_KEY],
    // },
  },
};
