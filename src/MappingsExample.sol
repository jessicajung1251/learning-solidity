// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Example {

    uint256 x; // 0x0
    mapping(address => bool) isMember; //base slot 0x1

    function join() external {
        //SSTORE(keccak256(msg.sender + 0x0), true)
        //abi encode takes the address that is 20 bytes and pads that out to 32 bytes and concatenate that together with 0, pad it out to 32 bytes and combine them and keccak hash those 2 things to create storage slot
        // bytes32 slot = keccak256(abi.encode(msg.sender, 0));
        // assembly {
        //     sstore(slot,true)
        // }
        isMember[msg.sender] = true;
    }

    function belongs() external view returns (bool) {

        //bytes32 slot = keccak256(abi.encode(msg.sender,1));
        //bool vaue;
        // assembly {
        //     value := sload(slot)
        // }
        //SLOAD(keccak256(msg.sender + 0x0))

        //return value;


        return isMember[msg.sender];
    }
}