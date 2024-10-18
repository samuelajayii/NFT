// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {DeployNFT} from "../script/NFT.s.sol";
import {NFT} from "../src/NFT.sol";

contract TestNFT is Test {
    DeployNFT public deployer;
    NFT public nft;
    address public USER = makeAddr("USER");
    string public constant GREEN_FISH = "ipfs://QmQbMqqoKwFoQ7yrqTrzJeydieLkarB9739BUSSMtsmrLX?filename=Fish.json";

    function setUp() public {
        deployer = new DeployNFT();
        nft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "NobleFish Token";
        string memory actualName = nft.name();
        assertEq(keccak256(abi.encodePacked(expectedName)), keccak256(abi.encodePacked(actualName)));
    }

    function testCanMindAndHaveABalance() public {
        vm.prank(USER);
        nft.mintNft(GREEN_FISH);

        assertEq(nft.balanceOf(USER), 1);
        assertEq(keccak256(abi.encodePacked(GREEN_FISH)), keccak256(abi.encodePacked(nft.tokenURI(0))));
    }
}
