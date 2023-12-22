// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

//Create a dynamic sized array of addresses called members


contract StackClub {

address[] public members;

//Create an external function addMember which has a single parameter: an address for a new member. Add this address to the members array.
    function addMember(address newMember) external {
        members.push(newMember);
    }
    
//Create a public view function isMember that takes an address and returns a bool indicating whether the address is a member or not.
    function isMember(address member) public view returns(bool) {
        for (uint256 i = 0; i < members.length; i++) {
            if (members[i] == member) {
                return true;
            }
        }
        return false;
    }
}
    
    
    
