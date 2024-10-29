// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SignatureChecker {
    // Mapping to store valid addresses
    mapping(address => bool) public validAddresses;

    constructor(address[] memory _validAddresses) {
        for (uint256 i = 0; i < _validAddresses.length; i++) {
            validAddresses[_validAddresses[i]] = true;
        }
    }

    function checkSigner(string memory message, bytes memory signature) public view returns (bool) {
        // Calculate the Ethereum Signed Message hash
        bytes32 messageHash = getEthSignedMessageHash(message);

        // Derive the signer address from the message hash and signature
        address signer = recoverSigner(messageHash, signature);

        // Check if the derived signer is in the valid addresses mapping
        return validAddresses[signer];
    }

    function recoverSigner(bytes32 hash, bytes memory signature) internal pure returns (address) {
        // Ensure the signature length is valid
        require(signature.length == 65, "Invalid signature length");

        bytes32 r;
        bytes32 s;
        uint8 v;

        // Split the signature into r, s, and v variables
        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }

        // Perform the ecrecover operation to derive the address
        address recoveredAddress = ecrecover(hash, v, r, s);
        require(recoveredAddress != address(0), "Invalid signature");

        return recoveredAddress;
    }

    function getEthSignedMessageHash(string memory message) public pure returns (bytes32) {
        bytes32 messageHash = keccak256(abi.encodePacked(message));
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));
    }
}
