// exercise on solidity programming language
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract simpleStorage {
    // variables
    uint storeData;
    uint mult;
    string userName;
    
    // functions
    function set(uint x) public {
        storeData = x;
    }
    
    function get() public view returns(uint) {
        return storeData;
    }
    
    function setName(string memory username) public {
        userName = username;
    }
    
    function getName() public view returns(string memory) {
        return userName;
    }
    
    function setMult(uint y) public {
        mult = y * 5;
    }
    
    function getMult() public view returns(uint) {
        return mult;
    }
}
