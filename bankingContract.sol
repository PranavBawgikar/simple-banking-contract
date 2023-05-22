    //SPDX-License-Identifier: MIT

    pragma solidity ^0.8.0;
    contract BankingContract{
        mapping(address => uint) private balances;
        address payable private owner;
        event LogDepositMade(address accoutAddress, uint amount);

        constructor(){
            owner = payable(msg.sender);
        }

        function deposit() public payable returns(uint){
            require((balances[msg.sender]+msg.value) >= balances[msg.sender], "Invalid deposit amount.");
            balances[msg.sender] += msg.value;
            emit LogDepositMade(msg.sender, msg.value);
            return balances[msg.sender];
        }

        function withdraw(uint withdrawAmount) public returns(uint remainingBal){
            require(withdrawAmount <= balances[msg.sender], "Insufficient balance.");
            balances[msg.sender] -= withdrawAmount;
            bool success = payable(msg.sender).send(withdrawAmount);
            require(success, "Withdrawal failed.");
            return balances[msg.sender];
        }

        function balance() view public returns(uint){
            return balances[msg.sender];
        }
    }