// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    mapping(address => bool) public members;

    function addMember(address newMember) external {
        members[newMember] = true;
    }

    function isMember(address checkMember) external view returns(bool) {
        return members[checkMember];
        
    }

    function removeMember(address nonMember) external {
        members[nonMember] = false;
    }


}