// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ERC777.sol";

contract PhsarUSD is ERC777 {
    address internal _creator;

    constructor(address[] memory defaultOperators_)
        ERC777("PhsarUSD", "USDP", defaultOperators_)
    {
        _creator = _msgSender();
        _defaultOperators[_creator] = true;
        _mint(_msgSender(), 1000000 * 10**18, "", "");
    }

    function mint(address operator, uint256 amount, bytes memory userData, bytes memory operatorData) public virtual {
        require(_msgSender() == _creator, "Require: mint by creator");
        require(operator == _creator, "Require: mint to creator account");
        _mint(operator, amount, userData, operatorData, true);
    }

    function operatorBurn(address account, uint256 amount, bytes memory data, bytes memory operatorData) public virtual override {
        require(_msgSender() == _creator, "Require: burn by creator");
        require(account == _creator, "Require: burn from creator account");
        super.operatorBurn(account, amount, data, operatorData);
    }

    function operatorSend(address sender, address recipient, uint256 amount, bytes memory data, bytes memory operatorData) public virtual override
    {
        if (sender == _creator) {
            require(_msgSender() == sender, "Require: only creator can send from creator address.");
        }
        super.operatorSend(sender, recipient, amount, data, operatorData);
    }

    function revokeOperator(address operator) public virtual override {
        require(!_defaultOperators[operator], "Require: revoke non-default operator");
        super.revokeOperator(operator);
    }
}
