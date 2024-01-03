// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}

    mapping(address => User) public users;

    modifier sufficientBalance(uint256 amount) {
        //require sender has sufficient balance
        require(users[msg.sender].balance >= amount, "Insufficient funds");
        _;
    }
    
    function createUser() external {   
        address userAddress = msg.sender;
        User storage user = users[userAddress];
        require(!users[msg.sender].isActive, "Sender is not an active user");    
        user.balance = 100;
        user.isActive = true;
        
    }

    function transfer(address recipient, uint256 amount) external sufficientBalance(amount) {   
        //require sender and recipient are active users     
        require(users[msg.sender].isActive, "Sender is not an active user");   
        require(users[recipient].isActive, "Recipient is not an active user");
        //update balances for both sender and recipient
        users[msg.sender].balance -= amount;
        users[recipient].balance += amount;

    }
        

}