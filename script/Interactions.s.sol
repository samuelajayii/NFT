// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {NFT} from "../src/NFT.sol";

contract MintNft is Script {
    string public constant GREEN_FISH = "ipfs://QmQbMqqoKwFoQ7yrqTrzJeydieLkarB9739BUSSMtsmrLX?filename=Fish.json";

    function run() external {
        address mostRecentlyDeployedNft = DevOpsTools.get_most_recent_deployment("NFT", block.chainid);
        mintNftOnContract(mostRecentlyDeployedNft);
    }

    function mintNftOnContract(address basicNftAddress) public {
        vm.startBroadcast();
        NFT(basicNftAddress).mintNft(GREEN_FISH);
        vm.stopBroadcast();
    }
}
