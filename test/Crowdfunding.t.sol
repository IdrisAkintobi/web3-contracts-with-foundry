// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {Crowdfunding} from "../src/Crowdfunding.sol";

contract CrowdfundingTest is Test {
    Crowdfunding public crowdfunding;

    address benefactor = address(0xBEEF);
    address donor = address(0xCAFE);
    uint256 goal = 1 ether;
    uint256 duration = 1 days;

    function setUp() public {
        crowdfunding = new Crowdfunding();
    }

    function testInit() public pure {
        assertEq(true, true);
    }
}
