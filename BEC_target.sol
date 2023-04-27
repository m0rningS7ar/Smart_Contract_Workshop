// SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

contract BEC_contract{
    mapping(address => uint) balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function getBalance() public view returns(uint){
        return balances[msg.sender];
    }

  function batchTransfer(address[] memory _receivers, uint256 _value) public payable returns (bool) {
    uint cnt = _receivers.length;
    uint256 amount = uint256(cnt) * _value;
    require(cnt > 0 && cnt <= 20);
    require(_value > 0 && balances[msg.sender] >= amount);

    balances[msg.sender] = balances[msg.sender] - (amount);
    for (uint i = 0; i < cnt; i++) {
        balances[_receivers[i]] = balances[_receivers[i]] + (_value);
        //Transfer(msg.sender, _receivers[i], _value);
    }
    return true;
  }
}

//! Action Steps:

//#  Deploy the contract from above.
//#  First put in a low number like 5 and review the output window, what do you get?
//#  Now put in the attack value in hex for aka 0xnumber 
//* 0x8000000000000000000000000000000000000000000000000000000000000000
//#  What happened?
//? As you will see an amount of 0 results which will pass the checks allowing an attack to work. Resulting in a very large value sent as the _value variable to the user. Causing hyperinflation of the token.

// ----------------------------------------------------------------

// fix the attack
//# add the lib to the code 
//* import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol" 


// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

// contract BEC_contract{
//     mapping(address => uint) balances;

//     function deposit() public payable {
//         balances[msg.sender] += msg.value;
//     }

//     function getBalance() public view returns(uint){
//         return balances[msg.sender];
//     }

//   function batchTransfer(address[] memory _receivers, uint256 _value) public payable returns (bool) {
//     uint cnt = _receivers.length;
//     uint256 amount = SafeMath.mul(uint256(cnt),_value);
//     require(cnt > 0 && cnt <= 20);
//     require(_value > 0 && balances[msg.sender] >= amount);

//     balances[msg.sender] = SafeMath.sub(balances[msg.sender], (amount));
//     for (uint i = 0; i < cnt; i++) {
//         balances[_receivers[i]] = SafeMath.add(balances[_receivers[i]],_value);
//         //Transfer(msg.sender, _receivers[i], _value);
//     }
//     return true;
//   }
// }