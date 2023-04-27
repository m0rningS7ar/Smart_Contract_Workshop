//# These are special comments in the code. The first line specifies the license under which the code is released, while the second line specifies the version of the Solidity compiler to use.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


//?This line defines the start of the smart contract and specifies its name.
contract HelloWorld_Bank {

    //? State Variable : owner is a public variable that holds the address of the contract owner. balances is a private mapping of addresses to unsigned integers, which stores the balances of each user in the contract.
    address public owner;
    mapping (address => uint) private balances;
    
    //? This is the constructor function of the contract, which sets the owner variable to the address that deploys the contract. The payable modifier allows the function to receive Ether when the contract is deployed.
    constructor () payable {
        owner = msg.sender; 
    }
    
    //? This is a public function that checks if the caller of the function is the owner of the contract. The view modifier indicates that the function does not modify the state of the contract.
    function isOwner () public view returns(bool) {
        return msg.sender == owner;
    }
    
    //? This is a modifier that restricts the execution of certain functions to the owner of the contract. The require statement checks if the caller of the function is the owner of the contract, and if not, it throws an exception with the error message.
    modifier onlyOwner() {
        require(isOwner(), "Only contract owner can call this function");
        _;
    }
    
    //? This is a public function that allows users to deposit Ether into the contract. The payable modifier allows the function to receive Ether. The require statement checks if the deposit will not overflow the user's balance, and if not, it throws an exception with the error message. The user's balance is then updated with the deposited amount.

    function deposit () public payable {
        require((balances[msg.sender] + msg.value) >= balances[msg.sender], "Deposit failed");
        balances[msg.sender] += msg.value;
    }
    
    //? This is a public function that allows users to withdraw Ether from the contract. The require statement checks if the user has enough balance to withdraw, and if not, it throws an exception with the error message. The user's balance is then updated with the withdrawn amount, and the amount is sent to the user's address using the transfer function.

    function withdraw (uint withdrawAmount) public {
        require (withdrawAmount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);
    }
    
    //? This is a public function that allows the owner of the contract to withdraw all the Ether in the contract. The onlyOwner modifier restricts the execution of the function to the owner of the contract. The amount is sent to the owner's address using the transfer function.

    function withdrawAll() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
    
    //? This is a public function that returns the balance of the caller's address in the contract. The view modifier indicates that the function does not modify the state of the contract.
    
    function getBalance () public view returns (uint){
        return balances[msg.sender];
    }
}
