// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
/*
 * @title Decentralized-Stable-Coin
 * @author vishwa
 * Collateral: Exogenous (ETH & BTC)
 * Minting:Algorithmic
 * Relative Stability:pegged to USD
 * governed by DSCEngine.
 */
contract DecentralizedStableCoin is ERC20Burnable{
    constructor() ERC20("DecentralizedStableCoin","DSC"){}
}
