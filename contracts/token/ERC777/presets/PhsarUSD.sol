// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ERC777.sol";

contract PhsarUSD is ERC777 {
    address internal _owner;

    constructor(address[] memory defaultOperators)
        ERC777("PhsarUSD", "USDP", defaultOperators)
    {
        _owner = _msgSender();
        _mint(_msgSender(), 1000000 * 10**18, "", "");
    }

    function mint(address operator, uint256 amount, bytes memory userData, bytes memory operatorData) public virtual {
        require(_msgSender() == _owner, "PhsarUSD: mint by original contract owner only.");
        require(_defaultOperators[operator] || operator == _owner, "PhsarUSD: mint to owner or default operators only");
        _mint(operator, amount, userData, operatorData, true);
    }

    function revokeOperator(address operator) public virtual override {
        require(!_defaultOperators[operator], "PhsarUSD: revoking default operator");
        super.revokeOperator(operator);
    }
}
