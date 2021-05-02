// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ITransactionValidator {
  
    function beforeTokenTransfer(address operator, address from, address to, uint256 amount) external view;

    function beforeAuthorizeOperator(address operator, address sender) external view;

    function beforeRevokeOperator(address operator, address sender) external view;

}