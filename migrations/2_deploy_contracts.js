const CopernicusToken = artifacts.require("CopernicusToken");
const CopernicusFactory = artifacts.require("CopernicusFactory");

module.exports = async function(deployer, network, accounts) {
  await deployer.deploy(CopernicusToken, "Copernicus", "CP", "21", web3.utils.toWei("0.4", "ether").toString(), "https://projectcopernicus.autonomous-times.com/assets/json/ticket_", accounts[0]);
  const token = await CopernicusToken.deployed();
  // await deployer.deploy(CopernicusFactory, token.address);
  // const factory = await CopernicusFactory.deployed();
  // await token.setMinter(factory.address);
};
