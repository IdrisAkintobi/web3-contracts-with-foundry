// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TimeLockedWallet {
    address public owner;
    uint256 public unlockTime;

    constructor(uint256 _unlockTime) {
        owner = msg.sender;
        unlockTime = _unlockTime;
    }

    receive() external payable { }

    function withdraw() external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(block.timestamp >= unlockTime, "Unlock time has not yet been reached");

        payable(owner).transfer(address(this).balance);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
