async function main() {
  const [deployer] = await ethers.getSigners();
  const gas = await ethers.provider.getGasPrice();
  console.log("Gas price is ", gas);

  console.log("Deploying contracts with the account:", deployer.address);
  const balance = await deployer.getBalance();
  const formatedBalance = ethers.utils.formatEther(balance);

  console.log("Deployer Account balance:", formatedBalance.toString(), "BNB");

  const contract = await ethers.getContractFactory("MultiSender");
  const deployed = await contract.deploy({ gasPrice: gas });

  console.log("Contract address is:", deployed.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
