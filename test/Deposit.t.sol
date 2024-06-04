// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Deposit} from "../src/Deposit.sol";

contract InvariantDeposit is Test {
    Deposit deposit;

    function setUp() public {
        deposit = new Deposit();
        vm.deal(address(deposit),100 ether);
        vm.deal(address(0xaaa), 1 ether);
    }

    function invariant_alwaysWithdrawable() public {
        vm.startPrank(address(0xaaa));
        deposit.deposit{value:1 ether}();
        vm.stopPrank();
        uint256 balanceBefore = deposit.balance(address(0xaaa));
        assertEq(balanceBefore, 1 ether);

        vm.startPrank(address(0xaaa));
        deposit.withdraw();
        vm.stopPrank();
        uint256 balanceAfter = deposit.balance(address(0xaaa));
        assertEq(balanceAfter, 0);
        assertGt(balanceBefore,balanceAfter);
    }

}
