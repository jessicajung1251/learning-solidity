//New Multiple Votes contract using enums
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    enum VoteChoice {
        NotVoted,
        Yes,
        No
    }

    struct Proposal {
        address target;
        bytes data;
        uint256 yesCount;
        uint256 noCount;
    }

    Proposal[] public proposals;
    //use emum directly for votes in mapping
    mapping(address => mapping(uint256 => VoteChoice)) votes;
    
    function newProposal(address target, bytes calldata data) external {
        //Initalize votes at 0 counts for yes, no
        Proposal memory newProp = Proposal(target, data, 0,0);
        //adds new proposal object of a proposal struct
        proposals.push(newProp);
    }

    function castVote(uint256 proposalId, VoteChoice voteChoice) external {
        //checks if the provided proposal id is less than the total number of proposals in the proposals array
        //if true, proposal exists and code executes
        //if false, invalid proposal and reverts with error message
        require(proposalId < proposals.length, "Proposal does not exist");
        //retrieves specific proposal from the proposals array and stores it in a variable for direct manipulation within the castVote function
        Proposal storage proposal = proposals[proposalId];
        VoteChoice oldVote = votes[msg.sender][proposalId];
        //in the case that users have already voted
        if (oldVote != VoteChoice.NotVoted) {
            //in the case that user already voted and the new vote is same as the previous vote
            if (oldVote == voteChoice) {
                revert("User has already voted with the same choice");
            } else {
                if (oldVote == VoteChoice.Yes) {
                    proposal.yesCount -= 1;
                    proposal.noCount +=1;
                } else {
                    proposal.yesCount += 1;
                    proposal.noCount -= 1;
                }
            }
        } else {
            //in the case that users have not voted
            if (voteChoice == VoteChoice.Yes) {
                proposal.yesCount += 1;
            } else {
                proposal.noCount += 1;
            }

        }

        votes[msg.sender][proposalId] = voteChoice;     

    }
}
