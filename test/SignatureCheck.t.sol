// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/SignatureChecker.sol";

contract SignatureCheckerTest is Test {
    SignatureChecker public signatureChecker;

    address[] addresses;
    address validSigner;
    address invalidSigner;

    // Set up the test environment
    // Define private keys
    uint256 validPrivateKey =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 invalidPrivateKey =
        0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d;

    function setUp() public {
        // Define valid addresses, including a valid signer
        validSigner = vm.addr(validPrivateKey);
        invalidSigner = vm.addr(invalidPrivateKey);
        addresses.push(validSigner);

        // Deploy the contract with the valid addresses
        signatureChecker = new SignatureChecker(addresses);
    }

    // Test for a valid signature with correct message
    function testValidSignature() public view {
        // Create a message
        string memory message = "Test message";

        // Hash the message using the Ethereum Signed Message Hash method
        bytes32 messageHash = signatureChecker.getEthSignedMessageHash(message);

        // Sign the message hash with the private key of the valid signer
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(validPrivateKey, messageHash);

        // Encode the signature
        bytes memory signature = abi.encodePacked(r, s, v);

        // Check if the signer derived from the signature is valid
        bool result = signatureChecker.checkSigner(message, signature);
        assertTrue(result, "Valid signer should be recognized");
    }

    // Test for an invalid signature with correct message
    function testInvalidSignature() public view {
        // Create a message
        string memory message = "Test message";

        // Hash the message using the Ethereum Signed Message Hash method
        bytes32 messageHash = signatureChecker.getEthSignedMessageHash(message);

        // Sign the message hash with the private key of an invalid signer
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            invalidPrivateKey,
            messageHash
        );

        // Encode the signature
        bytes memory signature = abi.encodePacked(r, s, v);

        // Check if the signer derived from the signature is invalid
        bool result = signatureChecker.checkSigner(message, signature);
        assertFalse(result, "Invalid signer should not be recognized");
    }

    // Test for a malformed signature
    function testMalformedSignature() public {
        // Create a message
        string memory message = "Test message";

        // Create a malformed signature (shorter than 65 bytes)
        bytes memory malformedSignature = new bytes(64);

        // Expect the call to revert due to invalid signature length
        vm.expectRevert("Invalid signature length");
        signatureChecker.checkSigner(message, malformedSignature);
    }

    // Test for invalid ecrecover case (zero address returned)
    function testInvalidECRecover() public {
        // Use a fake signature that would result in an invalid signer (zero address)
        string memory message = "Fake message";
        bytes
            memory fakeSignature = hex"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

        // Expect the call to revert due to invalid signature
        vm.expectRevert("Invalid signature length");
        signatureChecker.checkSigner(message, fakeSignature);
    }
}
