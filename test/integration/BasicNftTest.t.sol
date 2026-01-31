// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {BasicNft} from "src/BasicNFT.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {Test} from "forge-std/Test.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    // string public constant LAWN = "ipfs://QmUJC8mmic5Po4g6uH7Dsz5UgvfhADD59qHbjRai3FDSGM/lawn.json";
    string public constant LAWN = "ipfs://QmSBfKGZ5pA86uf7kQKcAxaMoRmQmNn2XXJbXmrFVw7G6Z";

    address public ashish = makeAddr("Ashish");

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public {
        assertEq("Doggi", basicNft.name());
    }

    function testSymbolIsCorrect() public {
        assertEq("DOG", basicNft.symbol());
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(ashish);
        basicNft.mintNft(LAWN);

        assert(basicNft.balanceOf(ashish) == 1);
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(LAWN)));
    }
}
