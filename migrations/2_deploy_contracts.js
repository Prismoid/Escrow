// var ConvertLib = artifacts.require("./ConvertLib.sol"); // artifacts(npm)
// var MetaCoin = artifacts.require("./MetaCoin.sol"); // artifacts(npm)
var Escrow = artifacts.require("./Escrow.sol"); // デプロイするコントラクトを入れる

module.exports = function(deployer) {
    //  deployer.deploy(ConvertLib);
    //   deployer.link(ConvertLib, MetaCoin);
    //   deployer.deploy(MetaCoin);
    deployer.deploy(Escrow); // デプロイするコントラクトを入れる
};
