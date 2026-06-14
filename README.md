# ERC721 Marketplace & NFT Collection

This project contains the smart contracts for an ERC721 NFT collection and marketplace, developed using the [Foundry](https://getfoundry.sh/) development framework.

## Project Overview

The repository features two distinct NFT smart contracts written in Solidity:

### 1. BasicNft
A straightforward implementation of an ERC721 token ("Doggi", symbol: "DOG"). 
- Uses off-chain metadata (IPFS or HTTP URLs) for the `tokenURI`.
- Anyone can mint a new NFT by providing a `tokenURI`.
- Uses an auto-incrementing token counter for IDs.

### 2. MoodNft
A dynamic, **100% fully on-chain** NFT ("Mood Nft", symbol: "MN").
- Generates its metadata and SVG images entirely on-chain without relying on external services like IPFS.
- Features a dynamic state: the owner of the NFT can call `flipMood(uint256 tokenId)` to change the mood of the NFT between `HAPPY` and `SAD`.
- The `tokenURI()` function dynamically computes base64-encoded JSON metadata containing a base64-encoded SVG image representing the current mood.

## Getting Started

### Prerequisites

You will need to have [Foundry](https://book.getfoundry.sh/getting-started/installation) installed.

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### Build

Compile the smart contracts:

```shell
$ forge build
```

### Test

Run the test suite:

```shell
$ forge test
```

### Format

Format your Solidity code:

```shell
$ forge fmt
```

### Local Node

Start a local Ethereum testing node (Anvil):

```shell
$ anvil
```

## Deployment

You can deploy the contracts to a network using `forge script`. Example:

```shell
$ forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
```

## License
MIT
