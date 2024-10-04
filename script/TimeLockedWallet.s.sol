// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Script.sol";
import "../src/TimeLockedWallet.sol";

contract DeployTimeLockedWallet is Script {
    uint256 constant DURATION = 1 weeks;

    function run() external {
        // Start the broadcast
        vm.startBroadcast(vm.envUint("DO_NOT_LEAK"));

        uint256 unlockTime = block.timestamp + DURATION;

        // Deploy the contract
        new TimeLockedWallet(unlockTime);

        // Stop broadcasting
        vm.stopBroadcast();
    }
}
