// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract MyToken is ERC20 {
    
    address public owner;

    constructor() ERC20("ShpoA", "SHA") {
        owner = msg.sender;
        //_mint(msg.sender, 1000 * 10 ** decimals());
    }

    function mintA (address to) public {
        require(msg.sender == owner);
        uint256 amount = 5000 * 10 ** decimals();
        _mint(to, amount);

    }

}