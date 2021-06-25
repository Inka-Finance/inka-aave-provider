pragma solidity =0.6.12;

import "./utils/Ownable.sol";
import './libraries/TransferHelper.sol';
import "./libraries/SafeMath.sol";

import "./eth/interfaces/IERC20.sol";
import "./eth/interfaces/ILendingPool.sol";
import "./eth/interfaces/IWETH.sol";
import "./eth/interfaces/IWETHGateway.sol";

contract InkaAaveProvider is Ownable {
    using SafeMath for uint256;

    event InkaAaveDepositOperation(address onBehalfOf, address asset, uint256 amount);

    address public WETH;
    address public iLendingPool;
    address public iWETHGateway;

    constructor (address _weth, address _iLendingPool, address _iWETHGateway) public {
        require(_weth != address(0), "InkaUniswapProvider: ZERO_WETH_ADDRESS");
        require(_iLendingPool != address(0), "InkaUniswapProvider: ZERO_LENDING_POOL_ADDRESS");
        require(_iWETHGateway != address(0), "InkaUniswapProvider: ZERO_WETH_GATEWAY_ADDRESS");
        WETH = _weth;
        iLendingPool = _iLendingPool;
        iWETHGateway = _iWETHGateway;
    }

    uint256 public providerFee = 10 * 10 ** 7;
    uint256 public constant FEE_DENOMINATOR = 10 ** 10;

    function depositETH(address _onBehalfOf, uint16 _referralCode) public payable returns (bool) {
        uint feeAmount = msg.value.mul(providerFee).div(FEE_DENOMINATOR);
        IWETHGateway(iWETHGateway).depositETH{value: msg.value.sub(feeAmount)}(iLendingPool, _onBehalfOf, _referralCode);
        return true;
    }

    function deposit(address _asset, uint256 _amount, address _onBehalfOf, uint16 _referralCode) public returns (uint) {
        require(_asset != address(0), "InkaAaveProvider: INVALID_ASSET_ADDRESS");
        require(_onBehalfOf != address(0), "InkaAaveProvider: INVALID_BEHALF_OF_ADDRESS");
        IERC20 assetToken = IERC20(_asset);
        require(assetToken.balanceOf(_onBehalfOf) >= _amount, "InkaAaveProvider: BALANCE_INSUFFICIENT");
        require(assetToken.allowance(_onBehalfOf, address(this)) >= _amount, "InkaAaveProvider: INVALID_ALLOWANCE");
        TransferHelper.safeTransferFrom(_asset, _onBehalfOf, address(this), _amount);
        uint feeAmount = _amount.mul(providerFee).div(FEE_DENOMINATOR);

        if(assetToken.allowance(address(this), iLendingPool) < _amount) {
            assetToken.approve(iLendingPool, _amount);
        }
        
        ILendingPool(iLendingPool).deposit(_asset, _amount.sub(feeAmount), _onBehalfOf, _referralCode);
        emit InkaAaveDepositOperation(_onBehalfOf, _asset, _amount);
        return 1;
    }


    receive() external payable { }

    function withdraw(address token) external onlyOwner {
        if (token == WETH) {
            uint256 wethBalance = IERC20(token).balanceOf(address(this));
            if (wethBalance > 0) {
                IWETH(WETH).withdraw(wethBalance);
            }
            TransferHelper.safeTransferETH(owner(), address(this).balance);
        } else {
            TransferHelper.safeTransfer(token, owner(), IERC20(token).balanceOf(address(this)));
        }
    }

    function setFee(uint _fee) external onlyOwner {
        providerFee = _fee;
    }

    function setWETH(address _weth) external onlyOwner {
        WETH = _weth;
    }
}