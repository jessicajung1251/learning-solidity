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

    mapping(address => Choices) public votesByVoter;

    modifier voteCheck() {
        require(hasVoted(msg.sender), "Address has not voted");
        _;
    }
 

	function createVote(Choices choice) external {
		// TODO: add a new vote to the array of votes state variable
        //require(voteOnce, "Already Voted");
        //votes.push(Vote(choice, msg.sender));
        //voteOnce = false;

        //mapping
        votesByVoter[msg.sender] = choice;

	}

//using the DRY principle
    function changeVote(Choices choice) external voteCheck {
        //uint256 voteIndex = _findVoteIndex(msg.sender);
        //votes[voteIndex].choice = choice;

        votesByVoter[msg.sender] = choice;
    }

 	// function _findVoteIndex(address voter) internal view returns(uint256) {
	// 	for (uint256 i = 0; i < votes.length; i++) {
	// 		if (votes[i].voter == voter) {
	// 			return i;
	// 		}
	// 	}
	// 	return type(uint256).max;
	// }   

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