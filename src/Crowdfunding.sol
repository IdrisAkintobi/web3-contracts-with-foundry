// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// @Author IdrisAkintobi
contract Crowdfunding {
    address private owner;

    struct Campaign {
        string id;
        string title;
        string description;
        address benefactor;
        uint256 goal;
        uint256 deadline;
        uint256 amountRaised;
        bool ended;
    }

    mapping(string => Campaign) public campaigns;

    // Events
    event CampaignCreated(
        string indexed _id,
        string _title,
        string _description,
        address indexed _benefactor,
        uint256 _goal,
        uint256 _deadline
    );

    event DonationReceived(string indexed _id, address indexed _donor, uint256 _amount);

    event CampaignEnded(string indexed _id, uint256 _amountRaised, address indexed _benefactor);

    modifier campaignExists(string memory _id) {
        require(bytes(campaigns[_id].id).length != 0, "Campaign does not exist");
        _;
    }

    modifier campaignNotEnded(string memory _id) {
        require(!campaigns[_id].ended, "Campaign has already ended");
        _;
    }

    function createCampaign(
        string memory _id,
        string memory _title,
        string memory _description,
        address _benefactor,
        uint256 _goal,
        uint256 _duration
    ) external {
        require(_goal > 0, "Goal should be greater than zero");

        Campaign memory newCampaign;
        newCampaign.id = _id;
        newCampaign.title = _title;
        newCampaign.description = _description;
        newCampaign.benefactor = _benefactor;
        newCampaign.goal = _goal;
        newCampaign.deadline = _duration + block.timestamp;
        newCampaign.ended = false;

        campaigns[_id] = newCampaign;

        emit CampaignCreated(_id, _title, _description, _benefactor, _goal, newCampaign.deadline);
    }

    function donateToCampaign(string memory _id) external payable campaignExists(_id) campaignNotEnded(_id) {
        Campaign storage campaign = campaigns[_id];

        require(block.timestamp <= campaign.deadline, "Campaign has ended");
        require(msg.value > 1000 wei, "You can not donate less than 1000 wei");

        campaign.amountRaised += msg.value;

        emit DonationReceived(_id, msg.sender, msg.value);
    }

    function endCampaign(string memory _id) external campaignExists(_id) campaignNotEnded(_id) {
        Campaign storage campaign = campaigns[_id];

        require(block.timestamp >= campaign.deadline, "Campaign is still ongoing");

        campaign.ended = true;

        if (campaign.amountRaised > 0) {
            // Transfer funds to the benefactor
            (bool sent,) = payable(campaign.benefactor).call{ value: campaign.amountRaised }("");
            require(sent, "Failed to send funds to benefactor");

            emit CampaignEnded(_id, campaign.amountRaised, campaign.benefactor);
        }
    }
}
