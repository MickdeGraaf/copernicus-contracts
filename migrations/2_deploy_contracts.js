const CopernicusToken = artifacts.require("CopernicusToken");

module.exports = function(deployer) {
  deployer.deploy(CopernicusToken, "Copernicus", "CP", "21", web3.utils.toWei("0.4", "ether").toString(), "https://API_END_POINT.com");
};
