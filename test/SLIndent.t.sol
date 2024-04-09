// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@src/SLIndent.sol";

contract SLIndent is Test {
  function testIndent() public {
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
  }
}