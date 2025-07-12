// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Layout of Contract:
// version
// imports
// interfaces, libraries, contracts
// Type declarations
// errors
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract PaymentReceiver is Ownable {
    // ERRORS
    error PaymentReceiver__ArrayLengthShouldBeEqual();
    error PaymentReceiver__AddressZeroIsNotAllowed();
    error PaymentReceiver__NewTokenLengthIsZero();
    error PaymentReceiver__CannotBeZeroAddress();
    error PaymentReceiver__TokenAlreadyExists();
    error PaymentReceiver__InvalidAddress();
    error PaymentReceiver__InvalidTokenSymbol();

    // STATE VARIABLES
    mapping(string tokenSymbol => address tokenAddress) private tokenAddresses;

    // EVENTS
    event TokensTransferred(
        address indexed payer, address indexed receiver, string indexed tokenSymbol, uint256 amount, string label
    );

    // MODIFIERS

    // FUNCTIONS
    constructor(string[] memory arrTokenSymbols, address[] memory arrTokenAddresses) Ownable(msg.sender) {
        if (arrTokenSymbols.length != arrTokenAddresses.length) {
            revert PaymentReceiver__ArrayLengthShouldBeEqual();
        }
        for (uint256 i = 0; i < arrTokenAddresses.length; i++) {
            if (arrTokenAddresses[i] == address(0)) {
                revert PaymentReceiver__AddressZeroIsNotAllowed();
            }
            tokenAddresses[arrTokenSymbols[i]] = arrTokenAddresses[i];
        }
    }

    // EXTERNAL FUNCTIONS
    function addNewToken(string memory newTokenName, address newTokenAddress) external onlyOwner {
        if (bytes(newTokenName).length == 0) {
            revert PaymentReceiver__NewTokenLengthIsZero();
        }
        if (newTokenAddress == address(0)) {
            revert PaymentReceiver__CannotBeZeroAddress();
        }
        if (tokenAddresses[newTokenName] != address(0)) {
            revert PaymentReceiver__TokenAlreadyExists();
        }

        tokenAddresses[newTokenName] = newTokenAddress;
    }

    function pay(address receiver, string memory tokenSymbol, uint256 amount, string memory label) external {
        if (receiver == address(0)) {
            revert PaymentReceiver__InvalidAddress();
        }

        if (tokenAddresses[tokenSymbol] == address(0)) {
            revert PaymentReceiver__InvalidTokenSymbol();
        }

        IERC20(tokenAddresses[tokenSymbol]).transferFrom(msg.sender, receiver, amount);

        emit TokensTransferred(msg.sender, receiver, tokenSymbol, amount, label);
    }

    // PUBLIC FUNCTIONS

    // INTERNAL FUNCTIONS

    // PRIVATE FUNCTIONS

    // VIEW AND PURE FUNCTION
    function getTokenAddress(string memory tokenSymbol) external view returns (address) {
        return tokenAddresses[tokenSymbol];
    }
}
