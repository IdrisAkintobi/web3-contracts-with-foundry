// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/TokenWithRoles.sol";

contract TokenWithRolesTest is Test {
    TokenWithRoles token;

    function setUp() public {
        token = new TokenWithRoles("RoleToken", "RTKN");
        token.grantRole(token.MINTER_ROLE(), address(this));
        token.grantRole(token.BURNER_ROLE(), address(this));
    }

    function testMint() public {
        token.mint(address(this), 100 * 10 ** 18);
        assertEq(token.balanceOf(address(this)), 1000 * 10 ** 18 + 100 * 10 ** 18);
    }

    function testBurn() public {
        token.burn(address(this), 50 * 10 ** 18);
        assertEq(token.balanceOf(address(this)), 1000 * 10 ** 18 - 50 * 10 ** 18);
    }

    function testFailMintWithoutRole() public {
        token.revokeRole(token.MINTER_ROLE(), address(this));
        token.mint(address(this), 100); // This should fail
    }
}
