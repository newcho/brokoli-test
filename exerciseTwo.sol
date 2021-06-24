// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ExerciseTwo {
    IUniswapV2Router routerV2 = IUniswapV2Router(0x7a250d5630b4cf539739df2c5dacb4c659f2488d);
    IERC20 constant WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    uint slippage = 5;
    function brokoliSwap(uint amountOutMin, address token0)  external payable returns(uint256 excessSlippage) {
        address[] memory path = new address[](2);
        path[0] = address(WETH);
        path[1] = token0;
        uint amountOutMinWithSlippage = amountOutMin * 100 / 95;
        uint balanceTokenBeforeSwap = IERC20(token0).balanceOf(address(this));
        routerV2.swapExactETHForTokens.value(msg.value).(amountOutMinWithSlippage, path, address(this), type(uint).max);
        uint balanceTokenAfterSwap = IERC20(token0).balanceOf(address(this));
        uint transferAmount = (balanceTokenAfterSwap - balanceTokenBeforeSwap) * 95 / 100;
        excessSlippage = balanceTokenAfterSwap - balanceTokenBeforeSwap - transferAmount;
        IERC20(token0).transfer(msg.sender, transferAmount);
    }
}