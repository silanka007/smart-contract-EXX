// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

// note: EVM is a runtime environment for smart contracts in ethereum

contract Token {
    address public minter;
    mapping(address => uint) public balances;
    
    /**
     * events allow clients react to specific
     * contract changes we declare.
     * Event is an inheritable member of a contract.
     * When an event is emitted, it stores the passed arguements to a transaction log.
     * These logs are stored on blockchain and are accessible using address of the contract till the contract is present 
     * on the blockchain.
    */
    event Sent(address from, address to, uint amount);
    
    /**
     * errors are returned to the caller of the function
     * they allow you to provide information about why an operation failed
    */
    error insufficientBalance(uint requested, uint available);
    
    // instantiating the contract, assign minter to owner addresss
    constructor () {
        minter = msg.sender;
    }
    
    /**
     * make new coin and send them to an address
     * only the owner can mint coin
    */
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }
    
    /**
     * send any amount of coin to an existing address
     * user does not need to login with username and password, rather ethereum keypair
    */
    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}