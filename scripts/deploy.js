const { ethers } = require("hardhat");

async function main() {

  const sheinixDAOContract = await ethers.getContractFactory("SheinixDAO");

  const deployedSheinixDAOContract = await sheinixDAOContract.deploy();
  
  await deployedSheinixDAOContract.deployed();

  console.log("SheinixDAO Contract Address:", deployedSheinixDAOContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });