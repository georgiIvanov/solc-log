// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {slFormat, slInternal} from "@src/SLFormat.sol";
import {sl} from "@src/SL.sol";

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
      slFormat.format("number: ", uint256(123 ether), slInternal.WAD), 
      "number: 123-000000000000000000"
    );

    assertEq(
      slFormat.format("number: ", uint256(123 * 1e6), 6), 
      "number: 123-000000"
    );
  }

  function testDecimalGreaterThanNumber() pure public {
    assertEq(
      slFormat.format("number: ", uint256(0), 6), 
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

  function testFormatAsHex() pure public {
    assertEq(
      slFormat.format(bytes32(uint256(700))),
      "0x00000000000000000000000000000000000000000000000000000000000002bc"
    );
    assertEq(
      slFormat.format(bytes32(type(uint256).max)),
      "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
    );
  }

  function testFormatAsBinary() pure public {
    assertEq(slFormat.formatAsBinary(254), "11111110");

    assertEq(slFormat.formatAsBinary(type(uint256).max), "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
    
    assertEq(
      slFormat.formatAsBinary("binary: ", 123),
      "binary: 1111011"
    );

    assertEq(
      slFormat.formatAsBinary("binary: ", 0),
      "binary: 0"
    );
  }

  function testFormatInt() pure public {
    assertEq(
      slFormat.format("Negative int: ", int256(0), slInternal.WAD),
      "Negative int: 0"
    );

    assertEq(
      slFormat.format("Negative int: ", int256(-123), 0),
      "Negative int: -123"
    );

    assertEq(
      slFormat.format("Negative int: ", -32_000_000, 6),
      "Negative int: -32-000000"
    );

    assertEq(
      slFormat.format("Zero int: ", int256(-0), slInternal.WAD),
      "Zero int: 0"
    );

    assertEq(
      slFormat.format("Positive int: ", int256(23_456_789), 0),
      "Positive int: 23456789"
    );

    assertEq(
      slFormat.format("Positive int: ", int256(23_456_789 ether), slInternal.WAD),
      "Positive int: 23456789-000000000000000000"
    );

    sl.logInt("Logging int 6 decimals: ", -32_000_000, 6);
  }
}
