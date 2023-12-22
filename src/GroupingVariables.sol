// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {

// struct definition of "agreement"
	struct Agreement {
		address depositor;
		address beneficiary;
		address arbiter;
		uint paymentAmount;
	}
// declare state variable "agreement" 
//this can be access throughout its lifecycle 
//agreement variable holds an instance of the Agreement struct, containing the details of the escrow agreement
	Agreement agreement;

	constructor(Agreement memory _agreement) {
        // needed to establish its initial values for any state variables it defines
		agreement = _agreement;
	}
}
		