// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {slFormat, slInternal} from "@src/SLFormat.sol";
import {sl} from "@src/SL.sol";

contract SLBool is Test {
  function testBoolFormatting() pure public {
    assertEq(
      slFormat.format("Some message: ", true), 
      "Some message: true"
    );

    assertEq(
      slFormat.format("Some message: ", false), 
      "Some message: false"
    );
  }
}
