// SPDX-License-Identifier: MIT*
pragma solidity ^0.8.7;

contract BcBank {

    uint256 public totalBankBalance;
    mapping(address => uint256) public BankUsers;
    error ExceedingAmount(address user, uint256 exceedingAmount);

    function paytoContact() external payable noZero(msg.value) {
        require(msg.value == 1 ether, "Yalnizca 1 ETH yatirilabilir");
        totalBankBalance += 1 ether;
        BankUsers[msg.sender] += 1 ether;
    }

    function withdraw(uint256 _amount) external noZero(_amount) {
        uint256 initialBalance = totalBankBalance;

        if(BankUsers[msg.sender] < _amount) {
            revert ExceedingAmount(msg.sender, _amount - BankUsers[msg.sender]);
        }

        totalBankBalance -= _amount;
        BankUsers[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);

        assert(totalBankBalance < initialBalance);
    }

    modifier noZero(uint256 _amount) {
        require(_amount != 0);
        _;
    }

}