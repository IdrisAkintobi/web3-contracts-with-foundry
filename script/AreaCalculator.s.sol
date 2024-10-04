// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Script, console } from "forge-std/Script.sol";
import { AreaCalculator } from "../src/AreaCalculator.sol";

contract AreaCalculatorScript is Script {
    AreaCalculator public areaCalculator;

    function setUp() internal { }

    function run() external {
        // Start the broadcast
        vm.startBroadcast(vm.envUint("DO_NOT_LEAK"));

        // Deploy the contract
        areaCalculator = new AreaCalculator();

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("AreaCalculator deployed to:", address(areaCalculator));
    }
}
