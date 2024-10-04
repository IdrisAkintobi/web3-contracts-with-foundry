// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Script.sol";
import "../src/Voting.sol";

contract DeployVoting is Script {
    function run() external {
        // Start the broadcast
        vm.startBroadcast(vm.envUint("DO_NOT_LEAK"));

        // Deploy the contract
        new Voting();

        // Stop broadcasting
        vm.stopBroadcast();
    }
}
