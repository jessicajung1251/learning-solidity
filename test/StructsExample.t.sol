// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/StructsExample.sol";

contract ExampleTest is Test {
    Example public example;

    function setUp() public {
        example = new Example();
    }

    function testExample() public {
        example.createOrder(address(0), address(1), 1 ether);

// acting as address 0 so that we can test following code
        hoax(address(0));

        example.payment{value: 1 ether}(0);

//can use this this we made a getter function 
        Example.Order memory order = example.getOrder(0);
        //(,,, Example.OrderStatus status) = example.orders(0);

        assertEq(address(example).balance, 1 ether);

        //console.log(uint8(status));

        //'assertEq' cannot compare 'enums' so we would have to convert these enums to uint8
        //status Created = 0, Paid = 1, ...
        assertEq(uint8(order.status), uint8(Example.OrderStatus.Paid));
    }

}