// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}

    mapping(address => User) public users;
    
    function createUser() external {
        address userAddress = msg.sender;
        User storage user = users[userAddress];
        require(!users[msg.sender].isActive, "User already exists");
        user.balance = 100;
        user.isActive = true;
    
    }

}