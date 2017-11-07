pragma solidity ^0.4.15;
contract Escrow {
  mapping (address => uint256) public balances;
  
  address public escrow = msg.sender; // デフォルトアカウントによるコントラクトインスタンス作成
  uint256 public totalEther = 0;
  
  // 買い手によるコントラクトへの預金
  function deposit() payable public returns(bool){
    balances[msg.sender] += msg.value;
    totalEther += msg.value;
    return true;
  }
  
  // 実際の支払い
  // 注意事項!!!!他のコントラクト呼び出しの際に、このコントラクトを呼ぶのを混ぜられるとお金を盗まれる可能性がある!!!!
  // DAOもその手の事件の可能性が高い(internal)で外部コントラクトからは呼べなくなる？)
  function payExcute(address _to, uint256 _money) public returns(bool){
    if (balances[msg.sender] < _money
	&& _money <= 0
	&& (balances[_to] + _money) <= balances[_to]) {
      return false;
    }
    balances[msg.sender] -= _money;
    balances[_to] += _money;
    return true;
  }

  // balancesに記載された金額以下だけ引き出し可能
  function withdraw(uint256 _money) public returns(bool){
    if (_money > balances[msg.sender]
	&& _money <= 0) {
      return false;
    }
    balances[msg.sender] -= _money;
    if (false == msg.sender.send(_money)) {
      return false;
    }
    return true;
  }

  // balanceの金額を確認
  function getBalance(address _target) public returns(uint256){
    return balances[_target];
  }
  
  // 意図しない返金が発生するため、selfdestructは残さない方が良い
  // selfdestruct(msg.sender)でmsg.senderがcontract addressに送金したお金だけ帰ってくる
  /*
  function killContract() internal {
    selfdestruct(escrow);
    //kills contract and returns funds to buyer
  }
  */

}
