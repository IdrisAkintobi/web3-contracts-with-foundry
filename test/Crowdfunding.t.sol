// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Test, console } from "forge-std/Test.sol";
import { Crowdfunding } from "../src/Crowdfunding.sol";

contract CrowdfundingTest is Test {
    Crowdfunding public crowdfunding;

    address benefactor;
    address donor;
    uint256 goal = 1 gwei;
    uint256 duration = 1 days;

    function setUp() public {
        crowdfunding = new Crowdfunding();
        donor = vm.addr(1);
        benefactor = vm.addr(2);

        //add funds
        vm.deal(donor, 1 ether);
        vm.deal(benefactor, 1 ether);
    }

    function testCreateCampaign() public {
        // Create a campaign
        crowdfunding.createCampaign(
            "campaign1", "Save the whales", "A campaign to save the whales", benefactor, goal, duration
        );

        // Verify that the campaign was created
        (
            string memory id,
            string memory title,
            string memory description,
            address campaignBenefactor,
            uint256 campaignGoal,
            uint256 deadline,
            uint256 amountRaised,
            bool ended
        ) = crowdfunding.campaigns("campaign1");

        assertEq(id, "campaign1");
        assertEq(title, "Save the whales");
        assertEq(description, "A campaign to save the whales");
        assertEq(campaignBenefactor, benefactor);
        assertEq(campaignGoal, goal);
        assertEq(amountRaised, 0);
        assertEq(ended, false);

        // Check that the deadline is correctly set
        assertTrue(deadline > block.timestamp);
        assertTrue(deadline <= block.timestamp + duration);
    }

    function testDonateToCampaign() public {
        // Create a campaign
        crowdfunding.createCampaign("campaign2", "Plant trees", "A campaign to plant trees", benefactor, goal, duration);

        // Simulate a donation
        vm.prank(donor);
        crowdfunding.donateToCampaign{ value: 10000 wei }("campaign2");

        // Verify that the donation was added
        (,,,,,, uint256 amountRaised,) = crowdfunding.campaigns("campaign2");
        assertEq(amountRaised, 10000 wei);
    }

    function testCannotDonateAfterDeadline() public {
        // Create a campaign
        crowdfunding.createCampaign(
            "campaign3", "Clean the oceans", "A campaign to clean the oceans", benefactor, goal, duration
        );

        // Move time forward to after the deadline
        vm.warp(block.timestamp + duration + 1);

        // Attempt to donate after the deadline
        vm.prank(donor);
        vm.expectRevert("Campaign has ended");
        crowdfunding.donateToCampaign{ value: 0.5 ether }("campaign3");
    }

    function testEndCampaignTransfersFunds() public {
        // Create a campaign
        crowdfunding.createCampaign(
            "campaign4", "Support education", "A campaign to support education", benefactor, goal, duration
        );

        // Simulate a donation
        vm.prank(donor);
        crowdfunding.donateToCampaign{ value: 0.8 ether }("campaign4");

        // Move time forward to after the deadline
        vm.warp(block.timestamp + duration + 1);

        // Capture the initial balance of the benefactor
        uint256 initialBalance = benefactor.balance;

        // End the campaign
        crowdfunding.endCampaign("campaign4");

        // Check that the campaign is marked as ended
        (,,,,,,, bool ended) = crowdfunding.campaigns("campaign4");
        assertTrue(ended);

        // Verify that the funds were transferred to the benefactor
        assertEq(benefactor.balance, initialBalance + 0.8 ether);
    }
}
