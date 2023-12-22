// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }
	
	struct Vote {
		Choices choice;
		address voter;
	}
	
	// TODO: create a public state variable: an array of votes
    Vote[] public votes;

	function createVote(Choices choice) external {
		// TODO: add a new vote to the array of votes state variable
        votes.push(Vote(choice, msg.sender));
	}
	//function to see whether voter has voted or not (y/n)
	//loop through all votes & check if voter address matches the address on the vote
    function hasVoted(address voter) public view returns(bool) {
        for (uint256 i=0; i < votes.length; i++) {
			if (votes[i].voter == voter) {
				return true;
			}
		}
		return false;
    }

	//function to see what choice voters voted
	//require address has voted
	//loop through all votes to find address's vote choice
    function findChoice(address voter) external view returns (Choices choice) {
		require(hasVoted(voter), "Address has not voted");

		for (uint256 i=0; i < votes.length; i++) {
			if (votes[i].voter == voter) {
				return votes[i].choice;
			}
		}
	}

}