const InkaAaveProvider = artifacts.require("InkaAaveProvider");

module.exports = function (deployer) {
    const WETH = "0xd0A1E359811322d97991E03f863a0C30C2cF029C";
    const ILendingPool = "0xE0fBa4Fc209b4948668006B2bE61711b7f465bAe";
    deployer.deploy(InkaAaveProvider, WETH, ILendingPool, "0xA61ca04DF33B72b235a8A28CfB535bb7A5271B70");
};
