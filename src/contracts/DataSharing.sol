// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
//@author: Jimmy Debe

import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract DataSharing {

    event withdrawal(uint256 amount, uint256 releaseTime);

    IERC20 private _reserveToken;
    address private _reserve;
    mapping(address => mapping(uint256 => bool)) private _purchases;
    mapping(uint256 => uint256) private _orderAmount;
    uint256 private _orderNum;
    address private _owner;

    constructor(address reserve, IERC20 token, address owner){
            _reserve = reserve;
            _reserveToken = token;
            _owner = owner;
    }

    /**
    * @dev Verify a purchase has been
    * return bool if orderNum is valid for address
    */
    function verifyPurchase(uint256 orderNum, address buyer) public view returns(bool) {
        return _purchases[buyer][orderNum];
    } 
    /**
    * @dev Set a price data order type ( can create more than one type)
    * MUST account for decimals
    */

    function setDataOrder() public virtual  {
        require(msg.sender == _owner);

    }
    /**
    * @dev Make a purchase for a data order
    * return orderNum
    */

    function dataPurchase(IERC20 token, uint256 amount, uint256 dNum ) public virtual returns(uint256) {
        require(amount <= _orderAmount[dNum]);
        _orderNum = _orderNum + 1;

        SafeERC20.safeTransferFrom(IERC20(token), msg.sender, address(this), amount);
        _purchases[msg.sender][_orderNum] = true;
        return _orderNum;
    }

    /**
    * @dev Withdraw funds(reserve only recieves funds)(profit sharing on-chain not implemented)
    * MUST account for decimals
    */

    function withdrawFunds(IERC20 token, uint256 amount ) public virtual {
        require(msg.sender == _owner);

        SafeERC20.safeTransferFrom(IERC20(token),address(this), _reserve, amount);

        emit withdrawal(amount, block.timestamp);
    }
    
}