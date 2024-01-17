// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/CastAVote.sol";

contract CastAVoteTest is Test {
    Voting public voting;
    bytes public _data = abi.encodePacked(bytes2(0x1337));
    address _target = address(1337);

    function setUp() public {
        voting = new Voting();
        voting.newProposal(_target, _data);
        voting.castVote(0, true);
        voting.castVote(0, true);
        voting.castVote(0, false);
    }

    function testProposal() public {
        (
            address target,
            bytes memory data,
            uint yesCount,
            uint noCount
        ) = voting.proposals(0);
        assertEq(target, _target);
        assertEq(data, _data);
        assertEq(yesCount, 2);
        assertEq(noCount, 1);
    }

    function testProposalRevertsOnInvalidId() public {
        // Ensure no proposals exist initially
        //require(voting.proposals.length == 1, "Unexpected proposals found");

        // Expect a revert when calling castVote with an invalid ID
        vm.expectRevert(bytes("Proposal doesn't exist"));
        voting.castVote(1, true); // Attempt to vote on a non-existent proposal
    }
}
