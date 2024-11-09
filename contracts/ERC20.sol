// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol';

contract MyToken is ERC20, Ownable, ERC20Permit {
  uint8 private immutable _decimal;
  constructor(
    address initialOwner,
    uint256 initialAmount,
    string memory tokenName,
    uint8 decimalUnits,
    string memory tokenSymbol
  ) ERC20(tokenName, tokenSymbol) Ownable(initialOwner) ERC20Permit(tokenName) {
    _mint(initialOwner, initialAmount * 10 ** decimalUnits);
    _decimal = decimalUnits;
  }

  function decimals() public view override returns (uint8) {
    return _decimal;
  }

  function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }
}
