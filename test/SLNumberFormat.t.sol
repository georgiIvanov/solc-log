// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@src/SLInternal.sol";

contract SLNumberFormat is Test {
  function testDecimalLessThanNumberLength() pure public {
    assertEq(
      slInternal.format(5 ether, slInternal.WAD), 
      "5-000000000000000000"
    );

    assertEq(
      slInternal.format(5 ether, 1), 
      "500000000000000000-0"
    );

    assertEq(
      slInternal.format("number: ", 123 ether, slInternal.WAD), 
      "number: 123-000000000000000000"
    );

    assertEq(
      slInternal.format("number: ", 123 * 1e6, 6), 
      "number: 123-000000"
    );
  }

  function testDecimalGreaterThanNumber() pure public {
    assertEq(
      slInternal.format("number: ", 0, 6), 
      "number: 0"
    );

    uint8 smallNum = 8;
    assertEq(
      slInternal.format("number: ", smallNum, 0), 
      "number: 8"
    );

    assertEq(
      slInternal.format("number: ", smallNum, slInternal.WAD), 
      "number: 8"
    );
  }

  function testSameNumberDifferentDecimals() pure public {
    uint128 fiveMillion = 5_000_000;
    assertEq(
      slInternal.format("5M, 1 dec: ", fiveMillion, 1), 
      "5M, 1 dec: 500000-0"
    );

    assertEq(
      slInternal.format("5M, 2 dec: ", fiveMillion, 2), 
      "5M, 2 dec: 50000-00"
    );

    assertEq(
      slInternal.format("5M, 6 dec: ", fiveMillion, 6), 
      "5M, 6 dec: 5-000000"
    );

    assertEq(
      slInternal.format("5M, 7 dec: ", fiveMillion, 7), 
      "5M, 7 dec: 0-5000000"
    );

    assertEq(
      slInternal.format("5M, 8 dec: ", fiveMillion, 8), 
      "5M, 8 dec: 5000000"
    );
  }
}
