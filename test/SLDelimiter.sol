// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {slFormat} from "@src/SLFormat.sol";

contract SLDelimiter is Test {

  function testLineDelimiters() pure public {
    assertEq(
      slFormat.lineDelimiter(), 
      "------------------------------------------------------------"
    );

    assertEq(
      slFormat.lineDelimiter("|"), 
      "----------------------------- | ----------------------------"
    );

    assertEq(
      slFormat.lineDelimiter("||"), 
      "---------------------------- || ----------------------------"
    );

    assertEq(
      slFormat.lineDelimiter("|||"), 
      "---------------------------- ||| ---------------------------"
    );
    
    assertEq(
      slFormat.lineDelimiter("Some examples"), 
      "----------------------- Some examples ----------------------"
    );
  }
}
