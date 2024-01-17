// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    function newProposal(address target, bytes calldata data) external {
        Proposal memory newProp = Proposal(target, data, 0, 0);
        proposals.push(newProp);
    }

    function castVote(uint proposalId, bool voteChoice) external {
        require(proposalId < proposals.length, "Proposal doesn't exist");
        Proposal storage proposal = proposals[proposalId];
        if (voteChoice) {
            proposal.yesCount += 1;
        } else{
            proposal.noCount += 1;
        }
    }

    
}
