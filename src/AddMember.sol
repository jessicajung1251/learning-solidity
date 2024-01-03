// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    //map address to bool that outputs whether address is a member or not
    mapping(address => bool) public members;
//address as inpu for potential new member
//by setting newMember = true, it adds address as a member 
    function addMember(address newMember) external {
        members[newMember] = true;
    }
}