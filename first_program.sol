// first line always be the licese 

// SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

//initiate the contract by `contract ` and its name 
// contract HelloWorld {
//     string public greet = "Hello World!";
// }

contract helloWorld {
    // initiate the constructor :  its run only one time when the actual 
    //smart contract is deployed
    constructor() public payable {
        // add the payable so we can send value to the contract as initial balance
    }

    //create function with `pure` it means we are not accessing any value 
    //or modifying any changes
    function hello() public pure returns(string memory){
        return "Hello World!" ;
    }
}


// pragma solidity ^0.8.0;

// contract HelloWorld {
//     string public greet = "Hello World!";
    
//     constructor() payable {}
    
//     function hello() public pure returns (string memory) {
//         return "Hello World!";
//     }
// }


//* The SPDX license identifier is added to specify the license under which the code is released.
//* The Solidity version is specified using the ^ symbol to indicate that it should be compatible with future minor versions.
//* The contract name is capitalized (HelloWorld instead of helloWorld).
//* A public string variable greet is added, which contains the text "Hello World!".
//* The pure keyword is used for the hello() function, which indicates that the function does not modify the state of the contract.
//* The memory keyword is used to specify that the string should be stored in memory rather than storage.
//* An empty payable constructor is added to allow for the contract to receive an initial value upon deployment.


//!call to HelloWorld.hello

//# CALL

//# from      0xBF8B5A94eD4dFB45089b455B1A0e296D6669c625
//# to       HelloWorld.hello() 0xADe285e11e0B9eE35167d1E25C3605Eba1778C86
//# transaction cost   21863 gas (Cost only applies when called by a  contract)
//#                     execution cost 591 gas (Cost only applies when called by a contract)
//#  hash     0x14557f9552d454ca865deb422ebb50a853735b57efaebcfc9c9abe57ba1836ed
//#  input    0x19f...f1d21
//# decoded input {}
//# decoded output {
//#                 "0": "string: Hello World"
//# }
//#  logs[]

