// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {Crowdfunding} from "../src/Crowdfunding.sol";

contract CounterScript is Script {
    Crowdfunding public crowdfunding;

    function setUp() public {}

    function run() public {
        // Start the broadcast
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Deploy the contract
        crowdfunding = new Crowdfunding();

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("AreaCalculator deployed to:", address(crowdfunding));
    }
}
