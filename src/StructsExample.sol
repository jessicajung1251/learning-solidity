// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Example {
    enum OrderStatus { 
        Created,  
        Paid
        //Shipped, 
        //Completed 
    }

    struct Order {
        address buyer;
        address seller;
        uint256 amount;
        OrderStatus status;

    }
//make this easy for people to modify order, so users don't have to iterate through entire array = expensive
//key in on the position inside of the order array
    Order[] public orders;

//use getter function to access Order struct
    function getOrder(uint key) external view returns(Order memory) {
        return orders[key];
    }

//this keys in on the position for users 
//'indexed' allows users to filter in on particular variables (however, if users won't use it don't add as it adds gas price)
    event OrderCreated(uint256 indexed key, uint256 amount);
    //OrderCreated.where(key :0);


    function createOrder(address buyer, address seller, uint256 amount) external {
        //if maintaining order, use '()' if moving positions around, use '{}'
        Order memory order = Order(buyer, seller, amount, OrderStatus.Created);
        orders.push(order);
//by emitting after pushing order, it shows the position that the order exists in currently
         emit OrderCreated(orders.length - 1, amount);

    }

    function payment(uint256 key) external payable {
        //need to change this into storage so that we can test the order status as paid 
        //if worried about modifying order, we can make a copy of the order variable -> more expensive
        Order storage order = orders[key];
        //require that the person making the payment is the buyer
        require(order.buyer == msg.sender);
        //require that users are paying the correct amount
        require(order.amount == msg.value);
        //check that the order hasn't already been paid for
        //require(order.status != OrderStatus.Paid);
        //if there are other statuses available where created -> paid -> ?
        require(order.status == OrderStatus.Created);
        // change the order status as paid - used in test contract to check status
        order.status = OrderStatus.Paid;



    }
}