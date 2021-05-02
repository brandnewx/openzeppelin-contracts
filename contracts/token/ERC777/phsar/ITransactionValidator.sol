// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ITransactionValidator {
  
    function beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256 amount
    ) external view;

}