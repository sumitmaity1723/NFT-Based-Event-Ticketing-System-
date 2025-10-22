/**
 * @type import('hardhat/config').HardhatUserConfigg
 */
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();
// click here
module.exports = {
  solidity: "0.8.20",
  networks: {
    coreTestnet: {
      url: "https://rpc.test2.btcs.network",
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      chainId: 1114,
    },
  },
  paths: {
    artifacts: "./artifacts",
    cache: "./cache",
    sources: "./contracts",
    tests: "./test",
  },
};

