// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract will {
    address owner;
    uint fortune;
    bool isDeceased;
    
    constructor () payable {
        owner = msg.sender;
        fortune = msg.value;
        isDeceased = false;
    }
    
    // adding modifier: modifier are like conditional statements
    // only person who can call this contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    // only allocate funds if friend's gramps is deceased
    modifier mustBeDeceased {
        require(isDeceased == true);
        _;
    }
    
    // family wallets
    address payable[] familyWallets;
    
    // map through inheritance
    mapping(address => uint) inheritance;
    
    // set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }
    
    // automating payout
    function payout() private mustBeDeceased {
        for(uint i=0; i < familyWallets.length; i++) {
           familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }
    
    // oracle switch simulation
    function setDeceased() public onlyOwner {
        isDeceased = true;
        payout();
    }
}