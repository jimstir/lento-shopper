// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
//@author: Jimmy Debe

import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract PayLater {

    event pay(uint256 amount, uint256 lendingNum);

    IERC20 private _reserveToken;
    address private _reserve;
    uint256 private _lendingNumber;
    //customerProgram[customerAddress][lendingNumber] = collateralAmount
    mapping(address => mapping(uint256 => uint256)) public customerProgram;
    //customerPayment[lendingNumber] = total payments to date
    mapping(uint256 => uint256) public customerPayments;
    // amountOwned[lendingNumber] = amount
    mapping(uint256 => uint256) public amountOwned;
    constructor(address reserve, IERC20 token){
            _reserve = reserve;
            _reserveToken = token;
    }

    /** @dev Open a lending contract, add collateral
    * Merchant verfiy before applying changes
    */
    function startProgram(uint256 amount, uint256 owned) public virtual{

        _lendingNumber = _lendingNumber + 1;
        owned = amountOwned[_lendingNumber];
        SafeERC20.safeTransferFrom(_reserveToken, msg.sender, address(this), amount);
        amount = customerProgram[msg.sender][_lendingNumber];

        emit pay(amount, _lendingNumber);
    }
    /** @dev Make a payment to an opened lending contract, 
    * - MUST be an ERC20 token
    * @param num lending number
    */
    function makePayment(uint256 num, uint256 amount) public{
        require(0 < customerProgram[msg.sender][num]);
        SafeERC20.safeTransferFrom(_reserveToken, msg.sender, address(this), amount);
        customerPayments[num] = customerPayments[num] + amount;

        emit pay(amount, num);
    }
    /** @dev Withdraw Collateral when lending contract is complete, 
    * MAY be collateral owner or reserve owner
    */
    function withdrawCollateral(uint256 num) public virtual{
        if(amountOwned[num] == customerPayments[num]){
            require(msg.sender == )
        }
        
    }



}