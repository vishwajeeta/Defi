// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
/*
 * @title Decentralized-Stable-Coin
 * @author vishwa
 * Collateral: Exogenous (ETH & BTC)
 * Minting:Algorithmic
 * Relative Stability:pegged to USD
 * governed by DSCEngine.
 */
contract DecentralizedStableCoin is ERC20Burnable, Ownable{

    error DecentralizedStableCoin_MustBeMoreThanZero();
    
    function mint(address _to,uint256 _amount)external onlyOwner returns(bool){
        if(_to == address(0)){
            revert DecentralizedStableCoin_NotZeroAddress();
        }
        if(_amount <= 0){
            revert DecentralizedStableCoin_MustBeMoreThanZero();
        }
        _mint(_to,_amount);
        return true;
    }
}
