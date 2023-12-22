// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }

	// TODO: create a vote struct and a public state variable
    struct Vote {
        Choices choice;
        address voter;
    }

    Vote public vote;

	function createVote(Choices choice) external {
		// TODO: create a new vote
        Vote memory newVote = Vote(choice, address(msg.sender)); 
        vote = newVote;
	}
}