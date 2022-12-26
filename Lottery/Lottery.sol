// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Lottery {
    address public owner;
    uint public totalPrice;
    uint public minTicketPrice;
    address[] players;
    //uint public playerCount = players.length;
    address public winner;

    constructor(){
        owner = msg.sender;
        minTicketPrice = 1 ether;
    }

function playercount() public view returns(uint){
    return players.length;
}
    function enter() payable public {
        require(minTicketPrice <= msg.value,"Insufficient funds");
        totalPrice += msg.value;
        players.push(msg.sender);
        //playerCount++;

    }

    function random() internal view returns(uint){
        uint num = uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,players)));
        return num;
    }

    function pickWinner() public {
        require(msg.sender == owner,"only owner can call");
        require(players.length >= 3,"not enough players");
        uint index = random() % players.length;
        winner = address(players[index]);
        payable(winner).transfer(totalPrice);

        totalPrice =0;
       // playerCount = 0;
        delete players;
    }
}