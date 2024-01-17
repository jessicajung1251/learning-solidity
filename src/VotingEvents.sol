//New Multiple Votes contract using enums
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    enum VoteChoice {
        NotVoted,
        Yes,
        No
    }

    event ProposalCreated(uint proposalId);

    event VoteCast(uint256 proposalId, address target);

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
        //get the id of the newly made proposal
        uint proposalId = proposals.length - 1;

        emit ProposalCreated(proposalId);
    }

    function castVote(uint256 proposalId, bool voteYes) external {
        require(proposalId < proposals.length, "Proposal does not exist");

        Proposal storage proposal = proposals[proposalId];
        //set this as oldVote since this is being repeated throughout
        VoteChoice oldVote = votes[msg.sender][proposalId];
        //need to create an empty variable so that we can store user's vote locally
        VoteChoice newVote;
        emit VoteCast(proposalId, msg.sender);

        if (oldVote != VoteChoice.NotVoted) {
            if (
                (oldVote == VoteChoice.Yes && voteYes) ||
                (oldVote == VoteChoice.No && !voteYes)
            ) {
            
                // revert("User has already voted with the same choice");
                return;
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
        //we now take user's local votes and change it in storage
        votes[msg.sender][proposalId] = newVote;
    }
}
