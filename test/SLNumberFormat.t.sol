// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {slFormat, slInternal} from "@src/SLFormat.sol";

contract SLNumberFormat is Test {
  function testDecimalLessThanNumberLength() pure public {
    assertEq(
      slFormat.format(5 ether, slInternal.WAD), 
      "5-000000000000000000"
    );

    assertEq(
      slFormat.format(5 ether, 1), 
      "500000000000000000-0"
    );

    assertEq(
      slFormat.format("number: ", 123 ether, slInternal.WAD), 
      "number: 123-000000000000000000"
    );

    assertEq(
      slFormat.format("number: ", 123 * 1e6, 6), 
      "number: 123-000000"
    );
  }

  function testDecimalGreaterThanNumber() pure public {
    assertEq(
      slFormat.format("number: ", 0, 6), 
      "number: 0"
    );

    uint8 smallNum = 8;
    assertEq(
      slFormat.format("number: ", smallNum, 0), 
      "number: 8"
    );

    assertEq(
      slFormat.format("number: ", smallNum, slInternal.WAD), 
      "number: 0-000000000000000008"
    );
  }

  function testSameNumberDifferentDecimals() pure public {
    uint128 fiveMillion = 5_000_000;

    assertEq(
      slFormat.format("5M, 0 dec: ", fiveMillion, 0), 
      "5M, 0 dec: 5000000"
    );

    assertEq(
      slFormat.format("5M, 1 dec: ", fiveMillion, 1), 
      "5M, 1 dec: 500000-0"
    );

    assertEq(
      slFormat.format("5M, 2 dec: ", fiveMillion, 2), 
      "5M, 2 dec: 50000-00"
    );

    assertEq(
      slFormat.format("5M, 6 dec: ", fiveMillion, 6), 
      "5M, 6 dec: 5-000000"
    );

    assertEq(
      slFormat.format("5M, 7 dec: ", fiveMillion, 7), 
      "5M, 7 dec: 0-5000000"
    );

    assertEq(
      slFormat.format("5M, 8 dec: ", fiveMillion, 8), 
      "5M, 8 dec: 0-05000000"
    );

    assertEq(
      slFormat.format("5M, 18 dec: ", fiveMillion, slInternal.WAD), 
      "5M, 18 dec: 0-000000000005000000"
    );
  }
}
