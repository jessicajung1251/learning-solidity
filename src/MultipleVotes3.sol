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
        Proposal memory newProp = Proposal(target, data, 0, 0);
        //adds new proposal object of a proposal struct
        proposals.push(newProp);
    }

    function castVote(uint256 proposalId, bool voteYes) external {

        require(proposalId < proposals.length, "Proposal does not exist");

        Proposal storage proposal = proposals[proposalId];
        VoteChoice oldVote = votes[msg.sender][proposalId];
        VoteChoice newVote;

        if (oldVote != VoteChoice.NotVoted) {

            if (
                (oldVote == VoteChoice.Yes && voteYes) ||
                (oldVote == VoteChoice.No && !voteYes)
            ) {
                revert("User has already voted with the same choice");
            } else {
                    // updateVote()
                if (voteYes) {
                    proposal.yesCount += 1;
                    proposal.noCount -= 1;
                    newVote = VoteChoice.Yes;
                } else {
                    proposal.yesCount -= 1;
                    proposal.noCount += 1;
                    newVote = VoteChoice.No;
                }
            }
        } else {
            //in the case that users have not voted
            if (voteYes) {
                proposal.yesCount += 1;
                newVote = VoteChoice.Yes;
            } else {
                proposal.noCount += 1;
                newVote = VoteChoice.No;
            }

        } 
        votes[msg.sender][proposalId] = newVote;
    }
}
