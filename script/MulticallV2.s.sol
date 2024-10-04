// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Script, console } from "forge-std/Script.sol";
import { MulticallV2 } from "../src/MulticallV2.sol";

contract CrowdfundingScript is Script {
    MulticallV2 public multicallV2;

    function setUp() public { }

    function run() public {
        // Start the broadcast
        vm.startBroadcast(vm.envUint("DO_NOT_LEAK"));

        // Deploy the contract
        multicallV2 = new MulticallV2();

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("MulticallV2 deployed to:", address(multicallV2));
    }
}
