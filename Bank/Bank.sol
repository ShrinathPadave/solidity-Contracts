// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank{
mapping(address => uint) balances;
event transfer(address from,address to, uint amount);

function balanceOf(address acHolder) public view returns(uint){
    return balances[acHolder];
}

function deposit() payable external returns(bool){
    balances[msg.sender] += msg.value;
    return true;
}

function withdraw(uint amount) public returns(bool){
    require(amount <= balances[msg.sender],"insufficient funds");
    balances[msg.sender] -= amount;
    payable(msg.sender).transfer(amount);
    return true;

}

function transferAmount(address to , uint amount) public {
    require(amount <= balances[msg.sender],"Not enough balance in acccount");
    balances[msg.sender] -= amount;
    balances[to] += amount;
    payable(to).transfer(amount);
    emit transfer(msg.sender,to, amount);
}
}