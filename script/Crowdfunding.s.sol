// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {Crowdfunding} from "../src/Crowdfunding.sol";

contract CounterScript is Script {
    Crowdfunding public crowdfunding;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        crowdfunding = new Crowdfunding();

        vm.stopBroadcast();
    }
}
