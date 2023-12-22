// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//Goal: When the donate function is called, trigger a self destruct in the contract

contract Contract {
    address public owner;
    address public charityAddress;


// initializes owner and charity address variables
//First, modify the constructor to accept a new argument: the charity address.
    constructor(address _charityAddress) {
        owner = msg.sender;
        charityAddress = _charityAddress;
    
    }

//only receives, does not perform any actions - called when contract receives ether
//this could be empty since we may want ether to accumulate w/o any immediate processing
    receive() external payable {
        
    }
//when tip function is called it transfers entire amount of ether to owner's address using the call function 
    function tip() public payable {
        (bool s, ) = owner.call{value: msg.value}("");
        require(s);
    }
//add a new function called donate. When this function is called transfer all remaining funds in the contract to the charity address.
//transfers all of the Ether in the contract to the charity address
//The function then calls the selfdestruct function to destroy the contract
//The payable keyword is used to cast the address to a payable address.
    function donate() public payable {
        (bool s, ) = charityAddress.call{value: address(this).balance}("");
        require(s);
//cast the address to an address payable
        selfdestruct(payable(charityAddress));
    }


}