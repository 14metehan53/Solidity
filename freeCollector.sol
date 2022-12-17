// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Collector {

    error err(address user, uint256 ExceedingAmount);

    address private onlyOwner;
    uint256 public totalBalance;
    mapping(address => uint256) public userBalance;

    constructor() {
        onlyOwner = msg.sender;
    }

    function getOwner() public view returns(address) {
        return onlyOwner;
    }

    function deposit() external ethX(msg.value) noZero(msg.value) payable {
        totalBalance += msg.value;
        userBalance[msg.sender] += msg.value;
    }

    function withdraw(address _to, uint256 _amount) external {
        uint256 BalanceControl = totalBalance;

        if(userBalance[msg.sender] < _amount) {
            /* 
            eğer kendi bakiyemden daha yüksek bir miktar çekmeye çalışırsam başkasının bakiyesini çekerim
            o yüzden burada kontrol işlemi gerçekleştiriyorum.
             */
            revert err(msg.sender, userBalance[msg.sender] - _amount);
        }
        userBalance[msg.sender] -= _amount;
        totalBalance -= _amount;

        payable(_to).transfer(_amount); // çekim işlemini bakiyeleri eksilttikten sonra yapmamız gerekiyor

        assert(totalBalance < BalanceControl); // her zaman doğru olmasını istediğimiz zaman assert kullanıyoruz
    }

    fallback() payable external { } // eğer kontrata dışarıdan para sokacaksak mutlaka fallback olmalı
    // receive() payable external { }

    modifier ethX(uint256 _amount) {
        require(_amount < 1 ether, "Tek seferde 1 ETH fazla yatirma islemi yapamazsiniz");
        _;
    }

    modifier noZero(uint256 _amount) {
        require(_amount != 0, "0'dan buyuk olmali");
        _;
    }

}