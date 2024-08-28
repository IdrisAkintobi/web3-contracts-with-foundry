// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/IDrisNFT.sol";

contract IDrisNFTTest is Test {
    IDrisNFT public idrisNFT;
    address public owner;
    address public user;

    function setUp() public {
        owner = address(this); // Set the owner to this test contract
        user = vm.addr(1); // Create a test address for the user
        idrisNFT = new IDrisNFT(owner);
    }

    function testCreateNFT() public {
        string memory tokenHASH = "unique-token-hash";
        string memory tokenMetadataHash = "ipfs://unique-metadata-hash";

        // Call the createNFT function
        uint256 tokenId = idrisNFT.createNFT(user, tokenHASH, tokenMetadataHash);

        // Check that the tokenCounter has been incremented
        assertEq(idrisNFT.tokenCounter(), 1);

        // Check that the token has been minted to the correct address
        assertEq(idrisNFT.ownerOf(tokenId), user);

        // Check that the token's metadata URI is correct
        assertEq(idrisNFT.tokenURI(tokenId), tokenMetadataHash);

        // Ensure the token URI hash is now marked as used
        vm.expectRevert("Token already minted");
        idrisNFT.createNFT(user, tokenHASH, "ipfs://another-metadata-hash");
    }

    function testCreateNFTOnlyOwner() public {
        // Switch the caller to a non-owner address
        vm.prank(user);

        string memory tokenHASH = "unique-token-hash";
        string memory tokenMetadataHash = "ipfs://unique-metadata-hash";

        // Attempt to call createNFT from a non-owner address and expect it to fail
        vm.expectRevert();
        idrisNFT.createNFT(user, tokenHASH, tokenMetadataHash);
    }
}
