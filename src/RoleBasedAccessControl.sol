// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract RoleBasedAccessControl {
    // Define a mapping of roles and members
    mapping(bytes32 => mapping(address => bool)) private roles;
    address public owner;

    event RoleGranted(bytes32 indexed role, address indexed account);
    event RoleRevoked(bytes32 indexed role, address indexed account);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this function");
        _;
    }

    modifier onlyRole(bytes32 role) {
        require(roles[role][msg.sender], "Access denied: You don't have the required role");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Grant a role to an account
    function grantRole(bytes32 role, address account) external onlyOwner {
        roles[role][account] = true;
        emit RoleGranted(role, account);
    }

    // Revoke a role from an account
    function revokeRole(bytes32 role, address account) external onlyOwner {
        roles[role][account] = false;
        emit RoleRevoked(role, account);
    }

    // Check if an account has a role
    function hasRole(bytes32 role, address account) external view returns (bool) {
        return roles[role][account];
    }
}
