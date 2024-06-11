 
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// create a contract called ExpenditureTracker
contract ExpenditureTracker{
//create a state variable for credit alert and debit alert
    uint256 public CreditAlert;
    uint256 public DebitAlert;
    mapping (address => uint256) public balance;
// using constructor to define the state
    constructor(uint256 _creditAlert, uint256 _debitAlert){
        CreditAlert = _creditAlert;
        DebitAlert = _debitAlert;
        balance[msg.sender] = CreditAlert - DebitAlert;
    }
// Create a function to update balance
    function UpdateBalance(uint256 _creditAlert, uint256 _debitAlert) public{
        CreditAlert = _creditAlert;
        DebitAlert = _debitAlert;
        balance[msg.sender] = CreditAlert - DebitAlert;
    }
// function that keep record of credit Alert
    function MoneyIn(uint256 amount) public {
        CreditAlert += amount;
        balance[msg.sender] += amount;
    }
// Implement modifier to only allow moneyOut if balance is greater than amount
    modifier notEnough() {
        require(balance[msg.sender] >= DebitAlert, "INSUFFICIENT FUND!");
        _;
    }
// function that keep record of Debit Alert
    function MoneyOut(uint256 amount) public{
        DebitAlert += amount;
        balance[msg.sender] -= amount;
    }
//implement a function to get the number of credit alert and number of debit alert
    function getAlert() public view returns(uint256 _creditAlert, uint256 _debitAlert){
        return (CreditAlert, DebitAlert);
    }
}