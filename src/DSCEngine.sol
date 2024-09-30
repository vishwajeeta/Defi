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

contract DSCEngine {

    //----------------Errors-------------------------
    error DSCEngine__NeedsMoreThanZero();
    //----------------Modifiers-----------------------
    modifier moreThanZero(uint256 amount){
        if(amount==0){
            revert DSCEngine__NeedsMoreThanZero();
        }
        _;
    }
    //----------------External functions---------------
    function depositCollateralAndMintDsc() external {}

    /**
     * @param tokenCollateralAddress The address of the token to deposit as collateral
     * @param amountCollateral The amount of collateral to deposit
    
     */
    function depositCollateral(
        address tokenCollateralAddress,
        uint256 amountCollateral
    ) external moreThanZero(amountCollateral) {}
    function redeemCollateralForDsc() external {}
    function redeemCollateral() external {}
    function mintDsc() external {}
    function burnDsc() external {}
    function lizuidate() external {}
    function getHealthFactor() external view {}
}
