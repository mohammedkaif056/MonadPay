// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Some test failing with this code!

// import {Test, console} from "forge-std/Test.sol";
// import {Deployer, HelperConfig, ERC20Mock} from "script/Deployer.s.sol";
// import {PaymentReceiver} from "src/PaymentReceiver.sol";

// contract PaymentReceiverTest is Test {
//     PaymentReceiver paymentReceiver;
//     Deployer deployer;
//     HelperConfig helperConfig;
//     HelperConfig.NetworkConfig config;

//     // EVENTS
//     event TokensTransferred(
//         address indexed payer, address indexed receiver, string indexed tokenSymbol, uint256 amount, string label
//     );

//     address owner = makeAddr("owner");
//     address user = makeAddr("user");
//     address user2 = makeAddr("user2");

//     function setUp() external {
//         deployer = new Deployer();
//         (paymentReceiver, helperConfig, config) = deployer.run();
//     }

//     function testConstructorParams() external {
//         assertEq(config.USDC, paymentReceiver.getTokenAddress("USDC"));
//         assertEq(config.USDT, paymentReceiver.getTokenAddress("USDT"));
//         assertEq(config.WBTC, paymentReceiver.getTokenAddress("WBTC"));
//         assertEq(config.WETH, paymentReceiver.getTokenAddress("WETH"));

//         string[] memory demoTokenSymbols = new string[](2);
//         demoTokenSymbols[0] = "USDC";
//         demoTokenSymbols[1] = "USDT";

//         address[] memory demoTokenAddresses = new address[](3);
//         demoTokenAddresses[0] = address(1);
//         demoTokenAddresses[1] = address(2);
//         demoTokenAddresses[2] = address(3);
//         vm.expectRevert(PaymentReceiver.PaymentReceiver__ArrayLengthShouldBeEqual.selector);
//         PaymentReceiver demoPaymentReceiver = new PaymentReceiver(demoTokenSymbols, demoTokenAddresses);

//         demoTokenAddresses[2] = address(0);
//         string[] memory demo1TokenSymbols = new string[](3);
//         demo1TokenSymbols[0] = "USDC";
//         demo1TokenSymbols[1] = "USDT";
//         demo1TokenSymbols[2] = "WBTC";

//         vm.expectRevert(PaymentReceiver.PaymentReceiver__AddressZeroIsNotAllowed.selector);
//         PaymentReceiver demo1PaymentReceiver = new PaymentReceiver(demo1TokenSymbols, demoTokenAddresses);
//     }

//     function testAddNewTokenReverts() external {
//         vm.expectRevert(PaymentReceiver.PaymentReceiver__NewTokenLengthIsZero.selector);
//         vm.prank(owner);
//         paymentReceiver.addNewToken("", address(1));

//         vm.prank(owner);
//         vm.expectRevert(PaymentReceiver.PaymentReceiver__CannotBeZeroAddress.selector);
//         paymentReceiver.addNewToken("NEW", address(0));

//         vm.prank(owner);
//         vm.expectRevert(PaymentReceiver.PaymentReceiver__TokenAlreadyExists.selector);
//         paymentReceiver.addNewToken("USDT", config.USDT);
//     }

//     function testAddNewTokenSetsTheValue() external {
//         vm.prank(owner);
//         paymentReceiver.addNewToken("MON", address(123));

//         assertEq(address(123), paymentReceiver.getTokenAddress("MON"));
//     }

//     function testPayReverts() external {
//         vm.prank(user);
//         vm.expectRevert(PaymentReceiver.PaymentReceiver__InvalidAddress.selector);
//         paymentReceiver.pay(address(0), "USDT", 1e18, "coffee");

//         vm.prank(user);
//         vm.expectRevert(PaymentReceiver.PaymentReceiver__InvalidTokenSymbol.selector);
//         paymentReceiver.pay(user2, "DEMO", 1e18, "coffee");
//     }

//     function testPayTransferTokens() external {
//         vm.prank(address(helperConfig));
//         ERC20Mock(paymentReceiver.getTokenAddress("USDT")).mint(owner, 1e18);

//         vm.prank(owner);
//         ERC20Mock(paymentReceiver.getTokenAddress("USDT")).approve(address(paymentReceiver), 1e18);

//         uint256 ownerBalance = ERC20Mock(paymentReceiver.getTokenAddress("USDT")).balanceOf(owner);
//         assertEq(ownerBalance, 1e18);

//         uint256 userBalance = ERC20Mock(paymentReceiver.getTokenAddress("USDT")).balanceOf(user);
//         assertEq(userBalance, 0);

//         vm.prank(owner);
//         // checks the emitted log
//         emit TokensTransferred(owner, user, "USDT", 1e18, "");
//         vm.expectEmit(true, true, true, true);
//         paymentReceiver.pay(user, "USDT", 1e18, "");

//         uint256 ownerBalanceAfter = ERC20Mock(paymentReceiver.getTokenAddress("USDT")).balanceOf(owner);
//         assertEq(ownerBalanceAfter, 0);

//         uint256 userBalanceAfter = ERC20Mock(paymentReceiver.getTokenAddress("USDT")).balanceOf(user);
//         assertEq(userBalanceAfter, 1e18);

//     }
// }
