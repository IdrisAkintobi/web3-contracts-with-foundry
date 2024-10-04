// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Voting {
    struct Proposal {
        string description;
        uint256 votes;
        bool executed;
    }

    address public owner;
    Proposal[] public proposals;

    constructor() {
        owner = msg.sender;
    }

    function createProposal(string calldata description) external {
        proposals.push(Proposal(description, 0, false));
    }

    function vote(uint256 proposalIndex) external {
        Proposal storage proposal = proposals[proposalIndex];
        require(!proposal.executed, "Proposal already executed");
        proposal.votes++;
    }

    function executeProposal(uint256 proposalIndex) external {
        Proposal storage proposal = proposals[proposalIndex];
        require(!proposal.executed, "Proposal already executed");
        proposal.executed = true;
    }

    function getProposal(uint256 proposalIndex) external view returns (string memory, uint256, bool) {
        Proposal memory proposal = proposals[proposalIndex];
        return (proposal.description, proposal.votes, proposal.executed);
    }
}
