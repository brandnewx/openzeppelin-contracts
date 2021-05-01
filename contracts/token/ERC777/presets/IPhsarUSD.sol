// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IPhsarUSD {
    
    function mint(address operator, uint256 amount, bytes memory userData, bytes memory operatorData) external;
    
}