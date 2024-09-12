// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "../lib/Base64.sol";

//@Author IdrisAkintobi
// NOTE: This contract is for **educational purposes only**.
// Storing large encoded data such as Base64 images directly on-chain is expensive and not a good practice.
// Consider storing metadata and image URIs off-chain, using decentralized storage like IPFS or Arweave for real-world applications.

contract IDrisSVGOncChainNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    mapping(string => bool) private _tokenURIExists;

    constructor(address initialOwner) ERC721("IDrisSVGOncChainNFT", "ISVGNC") Ownable(initialOwner) {}

    function createNFT(
        address _to,
        string calldata _svgImageName,
        string calldata _svgImageDescription,
        string calldata _base64SVGImage
    ) public onlyOwner returns (uint256) {
        require(!_tokenURIExists[_base64SVGImage], "Token already minted");

        uint256 newTokenId = tokenCounter;
        string memory svgImageURI = svgToImageURI(_base64SVGImage);
        string memory tokenURI = generateTokenMetadata(svgImageURI, _svgImageName, _svgImageDescription);

        _safeMint(_to, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        _tokenURIExists[_base64SVGImage] = true;

        tokenCounter++;
        return newTokenId;
    }

    /* Converts SVG to Base64 image uri */
    function svgToImageURI(string memory svg) private pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    /* Generate token metadata */
    function generateTokenMetadata(string memory svgURI, string memory svgName, string memory svgDescription)
        private
        pure
        returns (string memory)
    {
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "',
                            svgName,
                            '", ',
                            '"description": "',
                            svgDescription,
                            '", ',
                            '"image": "',
                            svgURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
