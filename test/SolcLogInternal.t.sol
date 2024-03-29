// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@src/SolcLogInternal.sol";

contract SolcLogInternalTest is Test {

  function testLineDelimiters() pure public {
    assertEq(
      SolcLogInternal.lineDelimiter(), 
      "------------------------------------------------------------"
    );

    assertEq(
      SolcLogInternal.lineDelimiter("|"), 
      "----------------------------- | ----------------------------"
    );

    assertEq(
      SolcLogInternal.lineDelimiter("||"), 
      "---------------------------- || ----------------------------"
    );

    assertEq(
      SolcLogInternal.lineDelimiter("|||"), 
      "---------------------------- ||| ---------------------------"
    );
    
    assertEq(
      SolcLogInternal.lineDelimiter("Some examples"), 
      "----------------------- Some examples ----------------------"
    );
  }

  function testNumberFormat() pure public {
    assertEq(
      SolcLogInternal.format(5 ether, SolcLogInternal.WAD), 
      "5-000000000000000000"
    );

    assertEq(
      SolcLogInternal.format("number: ", 123 ether, SolcLogInternal.WAD), 
      "number: 123-000000000000000000"
    );

    assertEq(
      SolcLogInternal.format("number: ", 123 * 1e6, 1e6), 
      "number: 123-000000"
    );

    assertEq(
      SolcLogInternal.format("number: ", 0, 1e6), 
      "number: 0"
    );
  }
}
