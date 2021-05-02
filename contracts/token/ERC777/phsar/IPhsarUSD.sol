// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ITransactionValidator.sol";

interface IPhsarUSD {
    
    function mint(address operator, uint256 amount, bytes memory userData, bytes memory operatorData) external;

    function setValidator(address validator) external;

    function getValidator() external view returns (ITransactionValidator);
    
}