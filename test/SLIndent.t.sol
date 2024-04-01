// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import "@src/SLIndent.sol";
import {console2} from "forge-std/console2.sol";

contract SLIndent is Test {
  // All tests depending on env have to run in same test function
  // to avoid concurrency issues
  function testIndent() public {
    // Demo env usage
    uint256 defaultValue = 13777;
    uint256 indentValue = vm.envOr(slIndent.InsetCountKey, defaultValue);
    string memory indentStr = vm.toString(indentValue);

    vm.setEnv(slIndent.InsetCountKey, indentStr);
    indentValue = vm.envOr(slIndent.InsetCountKey, uint256(777));
    assertNotEq(indentValue, 777);
    assertEq(defaultValue, indentValue);
    // Clear the env value
    vm.setEnv(slIndent.InsetCountKey, vm.toString(uint256(0)));

    // Run indent
    uint256 indentTimes = slIndent.indent();
    assertEq(indentTimes, 1);

    indentTimes = slIndent.indent();
    assertEq(indentTimes, 2);

    indentTimes = slIndent.outdent();
    assertEq(indentTimes, 1);

    indentTimes = slIndent.outdent();
    assertEq(indentTimes, 0);

    vm.expectRevert();
    indentTimes = slIndent.outdent();

    // Clear the env value
    vm.setEnv(slIndent.InsetCountKey, vm.toString(uint256(0)));
  }
}