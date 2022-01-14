const news = artifacts.require("NewsContract_lixi");

module.exports = function (deployer,network,accounts) {
  deployer.deploy(news);
  console.log(accounts);
};
