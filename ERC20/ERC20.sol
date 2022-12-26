// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Mycoin{
  
string public constant name = "Mytoken";
string public constant symbol = "MY";
uint public constant decimals = 18;

mapping (address=>uint) balances;
mapping(address => mapping(address => uint)) approval;

uint _totalSupply;
address owner;
constructor(uint Supply){
_totalSupply = Supply;
owner = msg.sender;
balances[msg.sender] = _totalSupply;

}
event Transfer(address indexed from, address indexed to, uint transferAmount);
event Approve(address indexed owner,address indexed delegate, uint approvedAmount);



function balanceOf(address tokenHolderAddress) public view returns(uint){
    return balances[tokenHolderAddress];
}

function totalSupply() public view returns(uint256){
 return _totalSupply;
}

function transfer(address to, uint transferAmount) public returns(bool){
    require(transferAmount < balances[msg.sender]);
    balances[msg.sender] -= transferAmount;
    balances[to] += transferAmount;

    emit Transfer(msg.sender,to,transferAmount);

    return true;
}

function approve(address delegate, uint approvedAmount) public returns(bool){
    require(approvedAmount <= balances[msg.sender]);
    approval[msg.sender][delegate] = approvedAmount;
    emit Approve(msg.sender,delegate,approvedAmount);
    return true;
}

function allowance(address approver,address delegate) public view returns(uint){
return approval[approver][delegate];
}

function transferFrom(address approver,address buyer,uint transferAmount) public returns(bool){
require(approval[approver][msg.sender] >= transferAmount);
require(transferAmount <= balances[approver]);

balances[owner] -= transferAmount;
balances[buyer] += transferAmount;
approval[owner][msg.sender] -= transferAmount;

return true;

}
}