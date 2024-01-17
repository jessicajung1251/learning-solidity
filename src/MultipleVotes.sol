// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint256 yesCount;
        uint256 noCount;
    }
    struct Vote {
        bool hasVoted;
        bool voteChoice;
    }

    Proposal[] public proposals;

    //nested mapping: first level has address that maps to another second level mapping of uint (proposalId) to boolean values (bool)
    //tracks user's votes by storing voting information for users on each proposal
    mapping(address => mapping(uint => Vote)) votes;

    function newProposal(address target, bytes calldata data) external {
        Proposal memory newProp = Proposal(target, data, 0, 0);
        proposals.push(newProp);
    }

    function castVote(uint proposalId, bool voteChoice) external {
        require(proposalId < proposals.length, "Proposal doesn't exist");
        Proposal storage proposal = proposals[proposalId];

        //check if user has voted or not
        //accesses the value within the votes mapping that corresponds to the current user (msg.sender) and the given proposal ID (proposalId)
        //votes mapping store a bool value indicating whether user has voted or not on a particular proposal
        bool hasVoted = votes[msg.sender][proposalId].hasVoted;
        //scenario where user has voted already
        if (hasVoted) {
            // Scenarios where a vote already exists:
            if (voteChoice == votes[msg.sender][proposalId].voteChoice) {
                // Vote already matches the current choice: revert
                revert("User has already voted with the same choice");
            } else {
                // Vote is changing: update counts and mapping
                if (voteChoice) {
                    proposal.yesCount += 1;
                    proposal.noCount -= 1;
                } else {
                    proposal.yesCount -= 1;
                    proposal.noCount += 1;
                }
                

            }
        } else {
            // Scenario where no vote exists:
            if (voteChoice) {
                proposal.yesCount += 1;
            } else {
                proposal.noCount += 1;
            }


            votes[msg.sender][proposalId].hasVoted = true;
        }
// Update mapping
        votes[msg.sender][proposalId].voteChoice = voteChoice;
    }
}
