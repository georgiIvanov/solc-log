// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@src/SLInternal.sol";

contract SLInternalTest is Test {

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

  function testNumberFormat() pure public {
    assertEq(
      slInternal.format(5 ether, slInternal.WAD), 
      "5-000000000000000000"
    );

    assertEq(
      slInternal.format("number: ", 123 ether, slInternal.WAD), 
      "number: 123-000000000000000000"
    );

    assertEq(
      slInternal.format("number: ", 123 * 1e6, 1e6), 
      "number: 123-000000"
    );

    assertEq(
      slInternal.format("number: ", 0, 1e6), 
      "number: 0"
    );
  }
}
