// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/Voting.sol";

contract VotingTest is Test {
    Voting voting;

    function setUp() public {
        voting = new Voting();
    }

    function testCreateProposal() public {
        voting.createProposal("Test Proposal");
        (string memory description,,) = voting.getProposal(0);
        assertEq(description, "Test Proposal");
    }

    function testVoteOnProposal() public {
        voting.createProposal("Test Proposal");
        voting.vote(0);
        (, uint256 votes,) = voting.getProposal(0);
        assertEq(votes, 1);
    }

    function testExecuteProposal() public {
        voting.createProposal("Test Proposal");
        voting.executeProposal(0);
        (,, bool executed) = voting.getProposal(0);
        assertTrue(executed);
    }
}
