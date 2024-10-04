// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Script, console } from "forge-std/Script.sol";
import { IDrisSVGOncChainNFT } from "../src/IDrisSVGOncChainNFT.sol";

contract IDrisSVGOncChainNFTScript is Script {
    IDrisSVGOncChainNFT public iDrisSVGOncChainNFT;

    function setUp() public { }

    function run() public {
        address initialOwner = vm.envAddress("INITIAL_OWNER");

        // Start the broadcast
        vm.startBroadcast(vm.envUint("DO_NOT_LEAK"));

        // Deploy the contract
        iDrisSVGOncChainNFT = new IDrisSVGOncChainNFT(initialOwner);

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("IDrisSVGOncChainNFTScript contract deployed to:", address(iDrisSVGOncChainNFT));
    }
}
