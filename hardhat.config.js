require("@nomiclabs/hardhat-waffle");
require("dotenv").config({ path: ".env" });

const ALCHEMY_API_KEY_URL = process.env.ALCHEMY_API_KEY_URL;

const OPTIMISM_KOVAN_PK = process.env.OPTIMISM_KOVAN_PK;

module.exports = {
  solidity: "0.8.4",
  networks: {
    optimism_kovan: {
      url: ALCHEMY_API_KEY_URL,
      accounts: [OPTIMISM_KOVAN_PK],
    },
  },
};