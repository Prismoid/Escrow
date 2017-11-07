// external library
const Web3 = require("web3");
// const solc = require("solc"); // install
const Tx = require('ethereumjs-tx'); // install
const ethUtils = require('ethereumjs-util'); // install
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
web3.eth.defaultAccount = web3.eth.accounts[1];
const hdkey = require('ethereumjs-wallet/hdkey'); // install
const Wallet = require('ethereumjs-wallet'); // install

// making a contract instance (Test)
var contract_json = require('../build/contracts/Escrow.json');
var addr = contract_json.networks[1].address;
var abi = contract_json.abi;
var contract = web3.eth.contract(abi).at(addr);

/*** エスクローのテスト ***/
// コントラクトアドレスへの預金(3 etherをデポジット)
// contract.deposit.sendTransaction({from: web3.eth.accounts[2], to: addr, value: web3.toWei(3, "ether")});

// コントラクトアドレスからの送金可能金額の更新
contract.payExcute.sendTransaction(web3.eth.accounts[1], web3.toWei(2, "ether"), {from: web3.eth.accounts[2]});

// コントラクトからの支払い
// var result = contract.withdraw.call(1, {from: web3.eth.accounts[1]});
// contract.withdraw.sendTransaction(web3.toWei(1, "ether"), {from: web3.eth.accounts[1]});
// console.log(result);

// 残高表示
// console.log(web3.toWei(100, "ether"));
console.log(web3.eth.accounts[2] + ": " + web3.eth.getBalance(web3.eth.accounts[2]).toString());
console.log(web3.eth.accounts[1] + ": " + web3.eth.getBalance(web3.eth.accounts[1]).toString());
