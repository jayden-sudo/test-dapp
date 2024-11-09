// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.24;

contract PiggyBank {
  uint256 private balance;
  address public owner;

  constructor(address initialOwner) {
    owner = initialOwner;
    balance = 0;
  }

  function deposit() public payable returns (uint256) {
    balance += msg.value;
    return balance;
  }

  function withdraw(
    uint256 withdrawAmount
  ) public returns (uint256 remainingBal) {
    require(msg.sender == owner);
    balance -= withdrawAmount;
    (bool success, ) = payable(msg.sender).call{
      value: withdrawAmount,
      gas: type(uint256).max
    }('');
    require(success, 'Withdraw failed');
    return balance;
  }
}
