// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

contract MyTestContract is Test {
    function add(uint a, uint b) public returns(uint) {
        return a + b;
    }

    function test_MyTest() public {
        uint256 a = 1;
        uint256 b = 2;
        console2.log(a);
        console2.log(b);
        assertEq(add(a, b), 3);

        assert(false); // expect to fail so we can see our console logs
    }
}
