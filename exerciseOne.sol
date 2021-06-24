// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ExerciseOne {
    IUniswapV3Router rouuterV3 = IUniswapV3Router(0xe592427a0aece92de3edee1f18e0157c05861564);
    IERC20 constant WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }
    function brokoliSwap(address tokenout, uint256 amountOutMinimum) external payable returns(uint256 excessSlippage) {
        rouuterV3.exactInputSingle.value(msg.value)(params);
        WETH.deposit.value(msg.value)();
        uint wethbalance = WETH.balanceOf(address(this));
        uint amountOutMinWithSlippage = amountOutMin * 100 / 95;
        uint balanceBeforeSwap = IERC20(tokenout).balanceOf(address(this));
        ExactInputSingleParams memory params = ExactInputSingleParams(address(WETH), tokenout, 300, address(this), type(uint).max, wethbalance, amountOutMinWithSlippage, 0);
        uint balanceAfterSwap = IERC20(tokenout).balanceOf(address(this));
        uint transferAmount = (balanceAfterSwap - balanceBeforeSwap) * 95 / 100; // Slippage is 5 %
        excessSlippage = balanceAfterSwap - balanceBeforeSwap - transferAmount;
    }
}