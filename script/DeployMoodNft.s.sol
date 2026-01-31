// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./images/sad.svg");
        string memory happySvg = vm.readFile("./images/happy.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgtoImgUri(sadSvg),
            svgtoImgUri(happySvg)
        );
        vm.stopBroadcast();

        return moodNft;
    }

    function svgtoImgUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseUrl = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        return string(abi.encodePacked(baseUrl, svgBase64Encoded));
    }
}
