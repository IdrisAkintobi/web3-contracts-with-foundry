// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Script, console } from "forge-std/Script.sol";
import { IDrisNFT } from "../src/IDrisNFT.sol";

contract IDrisNFTScript is Script {
    IDrisNFT public iDrisNFT;

    function setUp() public { }

    function run() public {
        address initialOwner = vm.envAddress("INITIAL_OWNER");

        // Start the broadcast
        vm.startBroadcast(vm.envUint("DO_NOT_LEAK"));

        // Deploy the contract
        iDrisNFT = new IDrisNFT(initialOwner);

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("IDrisNFT contract deployed to:", address(iDrisNFT));
    }
}
