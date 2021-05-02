// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ITransactionValidator.sol";
import "../../../utils/Address.sol";
import "../../../utils/Context.sol";

contract PhsarValidator is ITransactionValidator {
    using Address for address;

    function beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256 amount
    ) public virtual view override {
      
    }
}