// SPDX-License-Identifier: MIT
// Each address should only be allowed to call createVote once, if they try again, call should be reverted
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }
	
	struct Vote {
		Choices choice;
		address voter;
	}
	
	// TODO: create a public state variable: an array of votes
    Vote[] public votes;

    // bool switch for voting
    bool public voteOnce = true;

	function createVote(Choices choice) external {
		// TODO: add a new vote to the array of votes state variable
        require(voteOnce, "Already Voted");
        votes.push(Vote(choice, msg.sender));
        voteOnce = false;

	}
	//function to see whether voter has voted or not (y/n)
    function hasVoted(address voter) public view returns(bool) {
        for (uint256 i=0; i < votes.length; i++) {
			if (votes[i].voter == voter) {
				return true;
			}
		}
		return false;
    }

	//function to see what choice voters voted
    function findChoice(address voter) external view returns (Choices choice) {
		require(hasVoted(voter), "Address has not voted");

		for (uint256 i=0; i < votes.length; i++) {
			if (votes[i].voter == voter) {
				return votes[i].choice;
			}
		}
	}

}