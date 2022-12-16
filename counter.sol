// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Counter {

    uint private counter;

    function inc() external {
        counter += 1;
    }

    function dec() external {
        counter -= 1;
    }


    function getCounter() public view returns(uint256) {
        return counter;
    }

}