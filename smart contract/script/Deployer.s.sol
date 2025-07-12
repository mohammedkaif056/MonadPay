// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig, ERC20Mock} from "./HelperConfig.s.sol";
import {PaymentReceiver} from "../src/PaymentReceiver.sol";

contract Deployer is Script {
    string[] tokenSymbols;
    address[] tokenAddresses;

    uint256 constant LOCAL_CHAINID = 31337;

    function run() external returns (PaymentReceiver, HelperConfig, HelperConfig.NetworkConfig memory) {
        HelperConfig helperConfig = new HelperConfig();
        HelperConfig.NetworkConfig memory config = helperConfig.getNetworkConfig();

        tokenSymbols.push("USDC");
        tokenAddresses.push(config.USDC);

        tokenSymbols.push("USDT");
        tokenAddresses.push(config.USDT);

        tokenSymbols.push("WBTC");
        tokenAddresses.push(config.WBTC);

        tokenSymbols.push("WETH");
        tokenAddresses.push(config.WETH);

        if (block.chainid == LOCAL_CHAINID) {
            PaymentReceiver LocalPaymentReceiver = new PaymentReceiver(tokenSymbols, tokenAddresses);
            return (LocalPaymentReceiver, helperConfig, config);
        }

        vm.startBroadcast();
        PaymentReceiver paymentReceiver = new PaymentReceiver(tokenSymbols, tokenAddresses);
        vm.stopBroadcast();

        return (paymentReceiver, helperConfig, config);
    }
}
