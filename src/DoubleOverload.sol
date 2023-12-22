// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


//Create another pure external function double which takes two uint parameters
contract Contract {

    function double(uint x) external pure returns(uint) {
        return x + x;
    }
//Double both of the arguments and return both of them in the same order they were passed into the function.

    function double(uint x, uint y) external pure returns(uint, uint) {
        return(x + x, y + y);
    }

}