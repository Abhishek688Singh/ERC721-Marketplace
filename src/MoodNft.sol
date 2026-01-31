// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNftCantFlipMoodIfNotOwner();
    enum mood {
        HAPPY,
        SAD
    }

    uint256 private s_tokenCounter;
    string private s_sadSvgImgUri;
    string private s_happySvgImgUri;

    mapping(uint256 => mood) s_tokenIdToMood;

    constructor(
        string memory sadSvgImgUri,
        string memory happySvgImgUri
    ) ERC721("Mood Nft", "MN") {
        s_tokenCounter = 0;
        s_sadSvgImgUri = sadSvgImgUri;
        s_happySvgImgUri = happySvgImgUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert MoodNftCantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToMood[tokenId] == mood.HAPPY) {
            s_tokenIdToMood[tokenId] = mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[tokenId] == mood.HAPPY) {
            imageURI = s_happySvgImgUri;
        } else {
            imageURI = s_sadSvgImgUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":',
                                name(),
                                ',"discription":"Nft that changes Mood","attributes":[{"trait_type":"Moooooodd"},{"value":100}],"image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
