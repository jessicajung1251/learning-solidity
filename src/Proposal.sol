// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }
    //declares an array named proposals of type Proposal[]
    //it is public, meaning it is visible and accessible from outside the contract
    Proposal[] public proposals;

    function newProposal(address target, bytes calldata data) external {
        //creates a new Proposal object in memory with the provided target and data arguments and initalizes yesCount and noCount fields to 0
        Proposal memory newProp = Proposal(target, data, 0, 0);
        //adds the newly created Proposal object to the proposals array
        proposals.push(newProp);
    }

    
}
