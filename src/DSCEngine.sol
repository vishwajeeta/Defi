// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/** 
 * @title DSCEngine
 * @author Vishwa
 *
 * minimal contract with 1crypto==1$ peg.
 * This stablecoin has the properties:
 * - Exogenous Collateral
 * - Dollar Pegged
 * - Algorithmically Stable
 *
 * Our DSC system should always be "overcollateriat
 * @notice This contract is the core of the DSE System. it handles all the logic for minting and burning also redeeming DSC.+ depositing and withdrawing collateral.
*/

contract DSCEngine{
    function depositCollateralAndMintDsc() external {}
    function redeemCollateralForDsc() external {}
    function burnDsc() external {}
    
}