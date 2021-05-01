// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./PhsarUSD.sol";
import "../IERC777.sol";
import "../IERC777Recipient.sol";
import "../IERC777Sender.sol";
import "../../ERC20/IERC20.sol";
import "../../../utils/Address.sol";
import "../../../utils/Context.sol";
import "../../../utils/introspection/IERC1820Registry.sol";

contract PhsarUSDProxy is IERC777, IERC20, IPhsarUSD {
    using Address for address;

    address private _contractAddress;
    IPhsarUSD private _phsarUSD;
    IERC777 private _erc777;
    IERC20 private _erc20;

    constructor(address contractAddress) {
        require(contractAddress != address(0), "Require: non-zero contract address");
        _contractAddress = contractAddress;
        _phsarUSD = IPhsarUSD(_contractAddress);
        _erc777 = IERC777(_contractAddress);
        _erc20 = IERC20(_contractAddress);
    }

    /**
     * @dev See {IERC777-name}.
     */
    function name() public view virtual override returns (string memory) {
        return _erc777.name();
    }

    /**
     * @dev See {IERC777-symbol}.
     */
    function symbol() public view virtual override returns (string memory) {
        return _erc777.symbol();
    }

    /**
     * @dev See {ERC20-decimals}.
     *
     * Always returns 18, as per the
     * [ERC777 EIP](https://eips.ethereum.org/EIPS/eip-777#backward-compatibility).
     */
    function decimals() public pure virtual returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC777-granularity}.
     *
     * This implementation always returns `1`.
     */
    function granularity() public view virtual override returns (uint256) {
        return 1;
    }

    /**
     * @dev See {IERC777-totalSupply}.
     */
    function totalSupply() public view virtual override(IERC20, IERC777) returns (uint256) {
        return _erc777.totalSupply();
    }

    /**
     * @dev Returns the amount of tokens owned by an account (`tokenHolder`).
     */
    function balanceOf(address tokenHolder) public view virtual override(IERC20, IERC777) returns (uint256) {
        return _erc777.balanceOf(tokenHolder);
    }

    function send(address recipient, uint256 amount, bytes memory data) public virtual override {
        _erc777.send( recipient, amount, data);
    }

    function transfer(address recipient, uint256 amount) public virtual override(IERC20) returns (bool) {
        return _erc20.transfer(recipient, amount);
    }

    function burn(uint256 amount, bytes memory data) public virtual override  {
        _erc777.burn(amount, data);
    }

    function isOperatorFor(address operator, address tokenHolder) public view virtual override returns (bool) {
        return _erc777.isOperatorFor(operator, tokenHolder);
    }

    function authorizeOperator(address operator) public virtual override  {
        _erc777.authorizeOperator(operator);
    }

    function revokeOperator(address operator) public virtual override  {
        _erc777.revokeOperator(operator);
    }

    function defaultOperators() public view virtual override returns (address[] memory) {
        return _erc777.defaultOperators();
    }

    function operatorSend(address sender, address recipient, uint256 amount, bytes memory data, bytes memory operatorData) public virtual override {
        _erc777.operatorSend(sender, recipient, amount, data, operatorData);
    }

    function operatorBurn(address account, uint256 amount, bytes memory data, bytes memory operatorData) public virtual override {
        _erc777.operatorBurn(account, amount, data, operatorData);
    }

    function allowance(address holder, address spender) public view virtual override returns (uint256) {
        return _erc20.allowance(holder, spender);
    }

    function approve(address spender, uint256 value) public virtual override returns (bool) {
        return _erc20.approve(spender, value);
    }

    function transferFrom(address holder, address recipient, uint256 amount) public virtual override returns (bool) {
        return _erc20.transferFrom(holder, recipient, amount);
    }
 
    function mint(address account, uint256 amount, bytes memory userData, bytes memory operatorData) public virtual override {
        _phsarUSD.mint(account, amount, userData, operatorData);
    }
}