// SPDX-License-Identifier: MIT*
pragma solidity ^0.8.7;



contract HelloWorld {

    // Hello World 1

    string public helloMessage1 = "Merhaba Dunya!";
    /* output : Merhaba Dunya! */

    // Hello World 2

    string helloMessage2 = "Merhaba Dunya!";

    function getHelloWorld() public view returns(string memory) {
        return helloMessage2;
    }
    /* output : Merhaba Dunya! */
    
    // Hello World 3
    
    function helloWorld3() public pure returns(string memory) {
        return "Hello World!";
    }
    /* output : Hello World! */

}
