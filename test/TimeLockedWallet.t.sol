// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/TimeLockedWallet.sol";

contract TimeLockedWalletTest is Test {
    TimeLockedWallet wallet;

    function setUp() public {
        wallet = new TimeLockedWallet(block.timestamp + 1 days);
    }

    function testDeposit() public {
        payable(wallet).transfer(1 ether);
        assertEq(wallet.getBalance(), 1 ether);
    }

    function testWithdrawFailsBeforeUnlock() public {
        payable(wallet).transfer(1 ether);
        vm.expectRevert("Unlock time has not yet been reached");
        wallet.withdraw();
    }

    // function testWithdrawAfterUnlock() public {
    //     payable(wallet).transfer(1 ether);
    //     vm.warp(block.timestamp + 10 days);
    //     wallet.withdraw();
    //     assertEq(wallet.getBalance(), 0 ether);
    // }
}
