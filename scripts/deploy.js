const { ethers } = require("hardhat");

async function main() {
  const SimpleVoting = await ethers.getContractFactory("SimpleVoting");
  const contract = await SimpleVoting.deploy();

  await contract.deployed();

  console.log("✅ SimpleVoting deployed to:", contract.address);
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});
