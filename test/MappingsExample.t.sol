// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MappingsExample.sol";


contract ExampleTest is Test {
    Example public example;

    function setUp() public {
        example = new Example();
    }

    function testExample() public {
        //joining as a member here
        example.join();
        //we should expect to be a member (belong)
        assertEq(example.belongs(), true);
    }
}