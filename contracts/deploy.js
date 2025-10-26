/**
 * Deployment script for WorkflowMarketplace contract on Somnia Testnet
 *
 * Usage:
 *   npx hardhat run contracts/deploy.js --network somniaTestnet
 */

const hre = require("hardhat");

async function main() {
  console.log("🚀 Starting WorkflowMarketplace deployment...");
  console.log("📡 Network:", hre.network.name);
  console.log("⛓️  Chain ID:", hre.network.config.chainId);

  // Get deployer account
  const [deployer] = await hre.ethers.getSigners();
  console.log("👤 Deployer address:", deployer.address);

  // Check balance
  const balance = await hre.ethers.provider.getBalance(deployer.address);
  console.log("💰 Deployer balance:", hre.ethers.formatEther(balance), "STT");

  if (balance === 0n) {
    console.error("❌ Deployer has no STT tokens!");
    console.log("💡 Get testnet tokens from: https://testnet.somnia.network/");
    process.exit(1);
  }

  // Deploy WorkflowMarketplace
  console.log("\n📝 Deploying WorkflowMarketplace contract...");
  const WorkflowMarketplace = await hre.ethers.getContractFactory("WorkflowMarketplace");
  const marketplace = await WorkflowMarketplace.deploy();

  await marketplace.waitForDeployment();
  const marketplaceAddress = await marketplace.getAddress();

  console.log("✅ WorkflowMarketplace deployed to:", marketplaceAddress);

  // Get initial state
  const platformWallet = await marketplace.platformWallet();
  const platformFee = await marketplace.platformFeePercent();

  console.log("\n📊 Contract Configuration:");
  console.log("   Platform Wallet:", platformWallet);
  console.log("   Platform Fee:", platformFee.toString() + "%");

  // Save deployment info
  const deploymentInfo = {
    network: hre.network.name,
    chainId: hre.network.config.chainId,
    contractAddress: marketplaceAddress,
    deployer: deployer.address,
    platformWallet: platformWallet,
    platformFee: platformFee.toString(),
    deployedAt: new Date().toISOString(),
    blockNumber: await hre.ethers.provider.getBlockNumber(),
    explorerUrl: `https://shannon-explorer.somnia.network/address/${marketplaceAddress}`,
  };

  console.log("\n📄 Deployment Info:");
  console.log(JSON.stringify(deploymentInfo, null, 2));

  // Save to file
  const fs = require("fs");
  const path = require("path");
  const deploymentPath = path.join(__dirname, "deployment.json");
  fs.writeFileSync(deploymentPath, JSON.stringify(deploymentInfo, null, 2));
  console.log("\n💾 Deployment info saved to:", deploymentPath);

  console.log("\n🎉 Deployment completed successfully!");
  console.log("\n📌 Next Steps:");
  console.log("   1. Update .env with CONTRACT_ADDRESS=" + marketplaceAddress);
  console.log("   2. Verify contract: npx hardhat verify --network somniaTestnet " + marketplaceAddress);
  console.log("   3. Test the contract with demo transactions");
  console.log("   4. Integrate contract address in your app");

  // Wait for block confirmations
  console.log("\n⏳ Waiting for 5 block confirmations...");
  await marketplace.deploymentTransaction().wait(5);
  console.log("✅ Contract confirmed!");

  console.log("\n🔗 View on Somnia Explorer:");
  console.log("   " + deploymentInfo.explorerUrl);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment failed:", error);
    process.exit(1);
  });
