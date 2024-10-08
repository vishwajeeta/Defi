// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DecentralizedStableCoin} from "./DecentralizedStableCoin.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
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

contract DSCEngine is ReentrancyGuard {
    //----------------Errors-------------------------
    error DSCEngine__NeedsMoreThanZero();
    error DSCEngine__TokenAddressAndPriceFeedAddressesMustBeSameLength();
    error DSCEngine_NotAllowedToken();
    error DSCEngine__TransferFailed();

    //----------------State variable-----------------
    mapping(address token => address priceFeed) s_priceFeeds; // tokenToPriceFeed
    mapping(address user => mapping(address token => uint256 amount)) private s_collateralDeposited;
    mapping(address user => uint256 amountDscMinted)private s_DscMinted;

    DecentralizedStableCoin private immutable i_dsc;

    //----------------Events--------------------------
    event CollateralDeposited(address indexed user, address indexed token, uint256 amount);
    //----------------Modifiers-----------------------

    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert DSCEngine__NeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address token) {
        if (s_priceFeeds[token] == address(0)) {
            revert DSCEngine_NotAllowedToken();
        }
        _;
    }
    //----------------Constructor---------------------

    constructor(address[] memory tokenAddresses, address[] memory priceFeedAddresses, address dscAddress) {
        //USD priceFeeds
        if (tokenAddress.length != priceFeedAddresses.length) {
            revert DSCEngine__TokenAddressAndPriceFeedAddressesMustBeSameLength();
        }
        //Example ETH/USD,BTC/USD,SOL/USD,.,.,.,etc.
        for (uint256 i = 0; i < tokenAddress.length; i++) {
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddresses[i];
        }
        i_dsc = DecentralizedStableCoin(dscAddress);
    }

    //----------------External functions---------------
    function depositCollateralAndMintDsc() external {}

    /**
     * @param tokenCollateralAddress The address of the token to deposit as collateral
     * @param amountCollateral The amount of collateral to deposit
     */
    function depositCollateral(address tokenCollateralAddress, uint256 amountCollateral)
        external
        moreThanZero(amountCollateral)
        isAllowedToken(tokenCollateralAddress)
        nonReentrant
    {
        s_collateralDeposited[msg.sender][tokenCollateralAddress] += amountCollateral;
        emit CollateralDeposited(msg.sender, tokenCollateralAddress, amountCollateral);
        bool sucess=IERC20(tokenCollateralAddress).transferFrom(msg.sender, address(this), amountCollateral);
        if(!sucess){
            revert DSCEngine__TransferFailed();
        }
    }

    function redeemCollateralForDsc() external {}
    function redeemCollateral() external {}
    /**
    * @notice follows CEI
    * @param amountDscToMint the amount of decentralized stablecoin to mint
    * @notice They must have more collateral value than minimum threshold
    
     */
    function mintDsc(uint256 amountDscToMint) external moreThanZero(amountDscToMint) nonReentrant{
        s_DscMinted[msg.sender]+=amountDscToMint;
        // if they minted too much ($150 DSC , $100 ETH)
        _revertIfHealthFactorIsBroken(msg.sender);
    }
    function burnDsc() external {}
    function lizuidate() external {}
    function getHealthFactor() external view {}

    //------------------------Private & Internal view functions-------------------

    function _getAccountInformation(address user)private view returns(uint256 totalDscMinted,uint256 collateralValueInUsd){
        totalDscMinted=s_DscMinted[user];
        collateralValueInUsd= getAccountCollateralValue(user);
    }
    /**
    * return how close to liquidation a user is
    * if user goes below 1, then they can get liquidated
     */
    function _HealthFactor(address user) private view returns(uint256){
        // Total Dsc minted
        // total collateral Value
        (uint256 totalDscMinted, uint256 collateralValueInUsd)=_getAccountInformation(user);
    }
    function _revertIfHealthFactorIsBroken(address user) internal view{
        // 1. check health factor (do they have enough collateral ?)
        // 2.revert if they don't
    }


    //-------------------public & External view functions----------------------------
    function getAccountCollateralValue(address user)public view returns(uint256){
        // loop through each collateral
    }
}
