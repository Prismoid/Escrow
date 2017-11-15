pragma solidity ^0.4.15;
contract Escrow {
  mapping (address => uint256) public balances;
  
  address public escrow = msg.sender; // contract owner
  uint256 public totalEther = 0;
  
  // deposit and get Token(1 Token = 1 Wei)
  function deposit() payable public returns(bool){
    balances[msg.sender] += msg.value;
    totalEther += msg.value;
    return true;
  }
  
  // Attention!! Don't make vulnerable program about callstack attack 
  function payExcute(address _to, uint256 _money) public returns(bool){
    if (balances[msg.sender] >= _money
	&& _money > 0
	&& (balances[_to] + _money) > balances[_to]) {
      balances[msg.sender] -= _money;
      balances[_to] += _money;
      return true;
    }
    return false;
  }

  // withdraw function
  function withdraw(uint256 _money) public returns(bool){
    if (_money <= balances[msg.sender]
	&& _money > 0) {
      if (true == msg.sender.send(_money)) {
	balances[msg.sender] -= _money;
	totalEther -= _money;
	return true;
      }
    }
    return false;
  }

  // balanceの金額を確認
  function getBalance(address _target) public returns(uint256){
    return balances[_target];
  }
  
  function killContract() internal {
    selfdestruct(escrow);
    //kills contract and returns funds to owner
  }

}
