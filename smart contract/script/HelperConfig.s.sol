// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract HelperConfig is Script {
    error HelperConfig__UnsupportedNetwork();

    struct NetworkConfig {
        address USDC;
        address USDT;
        address WBTC;
        address WETH;
    }

    uint256 constant MONAD_TESTNET_CHAINID = 10143;
    uint256 constant ETH_MAINNET_CHAINID = 1;
    uint256 constant ETH_SEPOLIA_CHAINID = 11155111;
    uint256 constant LOCAL_CHAINID = 31337;

    function getNetworkConfig() external returns (NetworkConfig memory) {
        if (block.chainid == MONAD_TESTNET_CHAINID) {
            return getMonadTestnetConfig();
        } else if (block.chainid == ETH_MAINNET_CHAINID) {
            return getEthMainnetConfig();
        } else if (block.chainid == ETH_SEPOLIA_CHAINID) {
            return getEthSepoliaConfig();
        } else if (block.chainid == LOCAL_CHAINID) {
            return getLocalConfig();
        } else {
            revert HelperConfig__UnsupportedNetwork();
        }
    }

    function getMonadTestnetConfig() internal pure returns (NetworkConfig memory) {
        return NetworkConfig({
            USDC: 0xf817257fed379853cDe0fa4F97AB987181B1E5Ea,
            USDT: 0x88b8E2161DEDC77EF4ab7585569D2415a1C1055D,
            WBTC: 0xcf5a6076cfa32686c0Df13aBaDa2b40dec133F1d,
            WETH: 0xB5a30b0FDc5EA94A52fDc42e3E9760Cb8449Fb37
        });
    }

    function getLocalConfig() internal returns (NetworkConfig memory) {
        ERC20Mock USDC = new ERC20Mock();
        ERC20Mock USDT = new ERC20Mock();
        ERC20Mock WBTC = new ERC20Mock();
        ERC20Mock WETH = new ERC20Mock();
        return NetworkConfig({USDC: address(USDC), USDT: address(USDT), WBTC: address(WBTC), WETH: address(WETH)});
    }

    function getEthMainnetConfig() internal pure returns (NetworkConfig memory) {
        // Need to add NetworkConfig Tokens on Ethereum Mainnet
        return NetworkConfig({USDC: address(0), USDT: address(0), WBTC: address(0), WETH: address(0)});
    }

    function getEthSepoliaConfig() internal pure returns (NetworkConfig memory) {
        // Need to add NetworkConfig Tokens on Ethereum Sepolia
        return NetworkConfig({USDC: address(0), USDT: address(0), WBTC: address(0), WETH: address(0)});
    }
}
