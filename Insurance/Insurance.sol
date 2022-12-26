// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Insurance {

    uint public premium;
    address public insurer;
    address public insured;
    bool public active;
    uint public policyStart;
    uint public policyEnd;
    uint public claimAmount;

    
  mapping(uint=> mapping(address => uint)) policies;

     constructor(){
        insurer = msg.sender;
        premium = 1 ether;
}

 function getClaimAmountFromOwner() payable public returns(bool){
     require(msg.sender == insurer);
     claimAmount = msg.value;
     return true;
 }

 
    function Policyinfo() public pure returns(string memory){
        return "1.premium : 1 ether, claim 10 ether" "2.premium : 2 ether, claim 20 ether";
    }

    function buyPolicy(uint policyId) payable public returns(bool){
        require( premium <= msg.value,"Insufficient premium balance");
        require(block.timestamp >= 0);
        policies[policyId][msg.sender] = premium;
        insured = msg.sender;
        active = true;
        policyStart = block.timestamp;
        policyEnd = block.timestamp + 31556926;


        return true;
    }

    function claim(uint _policyId) public returns(bool){
        if(_policyId == 1){
          require(policies[_policyId][msg.sender] >= 1 ether,"premium not paid");
          require(block.timestamp <= policyEnd,"policy expired");
          require(active == true,"policy inactive");
          require(msg.sender == insured,"Invalid user");
          payable(msg.sender).transfer(claimAmount);
          active = false;
          claimAmount -= 10 ether;
        }
        else if(_policyId == 2){
          require(policies[_policyId][msg.sender] >= 2 ether,"premium not paid");
          require(block.timestamp <= policyEnd,"policy expired");
          require(active == true,"policy inactive");
          require(msg.sender == insured,"Invalid user");
          payable(msg.sender).transfer(claimAmount);
          active = false;
          claimAmount -= 20 ether;
        }
        else{
            return false;
        }
        return true;
        
    }

    
}
