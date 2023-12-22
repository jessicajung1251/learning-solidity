// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    enum Foods { Sushi, Pancakes, Steak, Noodles }

	Foods public food1 = Foods.Sushi;
	Foods public food2 = Foods.Pancakes;
	Foods public food3 = Foods.Steak;
	Foods public food4 = Foods.Noodles;
}