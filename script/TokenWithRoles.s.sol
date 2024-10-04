// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/TokenWithRoles.sol";

contract DeployTokenWithRoles is Script {
    function run() external {
        string memory name = "RoleToken";
        string memory symbol = "RTKN";

        // Start the broadcast
        vm.startBroadcast(vm.envUint("DO_NOT_LEAK"));

        // Deploy the contract
        TokenWithRoles token = new TokenWithRoles(name, symbol);

        // Grant minter and burner roles
        token.grantRole(token.MINTER_ROLE(), msg.sender);
        token.grantRole(token.BURNER_ROLE(), msg.sender);

        // Stop broadcasting
        vm.stopBroadcast();
    }
}
