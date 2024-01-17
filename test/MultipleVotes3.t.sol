// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MultipleVotes3.sol";

contract MultipleVoteTest3 is Test {
    Voting public voting;
    bytes public _data = abi.encodePacked(bytes2(0x1337));
    address _target = address(1337);

    function setUp() public {
        voting = new Voting();
        voting.newProposal(_target, _data);

        vm.prank(address(2));
        voting.castVote(0, true);
        vm.prank(address(3));
        voting.castVote(0, true);
        vm.prank(address(4));
        voting.castVote(0, false);
    }

    function testProposal() public {
        (, , uint yesCount, uint noCount) = voting.proposals(0);
        assertEq(yesCount, 2);
        assertEq(noCount, 1);
    }

    //simulates addresses 2 & 3 where votes switch from yes to no
    //asserts that the final vote count is 0 yes votes and 3 no votes
    function testSwitchFromSupports() public {
        vm.prank(address(2));
        voting.castVote(0, false);
        vm.prank(address(3));
        voting.castVote(0, false);

        (, , uint yesCount, uint noCount) = voting.proposals(0);
        assertEq(yesCount, 0);
        assertEq(noCount, 3);
    }

    //simulates address 4 where vote switch from no to yes
    //asserts that the final vote count is 3 yes and 0 no
    function testSwitchToSupports() public {
        vm.prank(address(4));
        voting.castVote(0, true);

        (, , uint yesCount, uint noCount) = voting.proposals(0);
        assertEq(yesCount, 3);
        assertEq(noCount, 0);
    }

    function testFailSameVote() public {
        vm.prank(address(3));
        voting.castVote(0, true);
        //vm.expectRevert;
        (, , uint yesCount, uint noCount) = voting.proposals(0);
        assertEq(yesCount, 2);
        assertEq(noCount, 1);
    }
}
