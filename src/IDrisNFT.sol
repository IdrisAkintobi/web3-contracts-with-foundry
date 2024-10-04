// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//@Author IdrisAkintobi
contract IDrisNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    mapping(string => bool) private _tokenURIExists;

    constructor(address initialOwner) ERC721("IDrisNFT", "IDRZ") Ownable(initialOwner) { }

    function createNFT(address _to, string calldata _tokenHASH, string calldata _tokenMetadataHash)
        public
        onlyOwner
        returns (uint256)
    {
        require(!_tokenURIExists[_tokenHASH], "Token already minted");

        uint256 newTokenId = tokenCounter;

        _safeMint(_to, newTokenId);
        _setTokenURI(newTokenId, _tokenMetadataHash);

        _tokenURIExists[_tokenHASH] = true;

        tokenCounter++;
        return newTokenId;
    }
}
