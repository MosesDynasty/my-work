// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExpenditureTracker {
    uint256 public CreditAlert;
    uint256 public DebitAlert;
    mapping(address => uint256) public balance;

    event BalanceUpdated(address indexed user, uint256 newBalance);
    event MoneyInEvent(address indexed user, uint256 amount);
    event MoneyOutEvent(address indexed user, uint256 amount);

    constructor(uint256 _creditAlert, uint256 _debitAlert) {
        CreditAlert = _creditAlert;
        DebitAlert = _debitAlert;
        balance[msg.sender] = CreditAlert - DebitAlert;
        emit BalanceUpdated(msg.sender, balance[msg.sender]);
    }

    function updateBalance(uint256 _creditAlert, uint256 _debitAlert) public {
        CreditAlert = _creditAlert;
        DebitAlert = _debitAlert;
        balance[msg.sender] = CreditAlert - DebitAlert;
        emit BalanceUpdated(msg.sender, balance[msg.sender]);
    }

    function moneyIn(uint256 amount) public {
        CreditAlert += amount;
        balance[msg.sender] += amount;
        emit MoneyInEvent(msg.sender, amount);
        emit BalanceUpdated(msg.sender, balance[msg.sender]);
    }

    modifier notEnough(uint256 amount) {
        require(balance[msg.sender] >= amount, "INSUFFICIENT FUND!");
        _;
    }

    function moneyOut(uint256 amount) public notEnough(amount) {
        DebitAlert += amount;
        balance[msg.sender] -= amount;
        emit MoneyOutEvent(msg.sender, amount);
        emit BalanceUpdated(msg.sender, balance[msg.sender]);
    }

    function getAlert() public view returns (uint256 _creditAlert, uint256 _debitAlert) {
        return (CreditAlert, DebitAlert);
    }
}
