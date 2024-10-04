// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Script, console } from "forge-std/Script.sol";
import { ProposalContract } from "../src/ProposalContract.sol";

contract CrowdfundingScript is Script {
    ProposalContract public proposalContract;

    function setUp() public { }

    function run() public {
        // Start the broadcast
        vm.startBroadcast(vm.envUint("DO_NOT_LEAK"));

        // Deploy the contract
        proposalContract = new ProposalContract();

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("ProposalContract deployed to:", address(proposalContract));
    }
}
