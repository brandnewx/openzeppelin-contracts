// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ERC777.sol";

contract PhsarUSD is ERC777 {
    constructor(address[] memory defaultOperators)
        ERC777("PhsarUSD", "PUSD", defaultOperators)
    {
        _mint(msg.sender, 10000 * 10**18, "", "");
    }
}
