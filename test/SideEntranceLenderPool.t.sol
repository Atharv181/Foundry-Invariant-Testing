// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "forge-std/console2.sol";

import "../src/SideEntranceLenderPool.sol";
import "./handler/Handler.sol";

contract InvariantSideEntranceLenderPool is Test {

    SideEntranceLenderPool pool;
    Handler handler;

    function setUp() public {
        pool = new SideEntranceLenderPool{value: 10 ether}();
        handler = new Handler(pool);
        targetContract(address(handler));
    }

    function invariant_poolBalanceAlwaysGtThanInitialBalance() external {
        assert(address(pool).balance >= pool.initialPoolBalance());
    }

}