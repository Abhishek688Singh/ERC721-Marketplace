// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {BasicNft} from "src/BasicNFT.sol";
import {MoodNft} from "src/MoodNft.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {DevOpsTools} from "@devops/src/DevOpsTools.sol";
import {Script} from "forge-std/Script.sol";

contract MintBasicNft is Script {
    string public constant LAWN =
        "ipfs://QmTBGGwoiJGsyHaYHAbz6bNVTQLqC8ct8CGBNGMnUCjJig/";

    function run() public {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentDeployed);
    }

    function mintNftOnContract(address mostRecentDeployed) public {
        vm.startBroadcast();
        BasicNft(mostRecentDeployed).mintNft(LAWN);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() public {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        mintNftOnContract(mostRecentDeployed);
    }

    function mintNftOnContract(address mostRecentDeployed) public {
        vm.startBroadcast();
        MoodNft(mostRecentDeployed).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    function run() public {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        flipNftMoodOnContract(mostRecentDeployed);
    }

    function flipNftMoodOnContract(address mostRecentDeployed) public {
        uint256 ownerKey = vm.envUint("PRIVATE_KEY_usedForInteractionPRIVATE_KEY"); // SAME key used to mint
        vm.startBroadcast(ownerKey);
        MoodNft(mostRecentDeployed).flipMood(0);
    }
}
