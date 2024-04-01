// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@src/SLInternal.sol";

contract SLDelimiter is Test {

  function testLineDelimiters() pure public {
    assertEq(
      slInternal.lineDelimiter(), 
      "------------------------------------------------------------"
    );

    assertEq(
      slInternal.lineDelimiter("|"), 
      "----------------------------- | ----------------------------"
    );

    assertEq(
      slInternal.lineDelimiter("||"), 
      "---------------------------- || ----------------------------"
    );

    assertEq(
      slInternal.lineDelimiter("|||"), 
      "---------------------------- ||| ---------------------------"
    );
    
    assertEq(
      slInternal.lineDelimiter("Some examples"), 
      "----------------------- Some examples ----------------------"
    );
  }
}
