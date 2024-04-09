// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@src/SL.sol";

// forge test -vv --mt testPrintNumbersInDifferentDenominations
contract SLConsoleTest is Test {
  function testPrintNumbersInDifferentDenominations() pure public {
    sl.indent();
    sl.logLineDelimiter("Some examples");
    sl.log("Logs from:", address(0x1111111111111111111111111111111111111111));
    sl.log(address(0x1111111111111111111111111111111111111111));
    sl.log("number: ", 123 ether);
    sl.log("1 ether: ", 1 ether);
    sl.log("USDC Denom: ", 123 * 1e6, 6); // USDC denomination
    sl.log("small number (zero decimals): ", 8, 0);
    sl.log("small number (WAD decimals) : ", 8);
    sl.log("Zero: ", 0, 0);
    sl.log(0, 0);
    sl.indent();
    sl.logLineDelimiter("Nested examples");
    sl.log("5M (WAD decimals) : ", 5_000_000);
    sl.log("5M (Zero decimals): ", 5_000_000, 0);
    sl.log("5M (6 decimals)   : ", 5_000_000, 6);
    sl.log("Messages can be indented");
    sl.logLineDelimiter();
    sl.outdent();

    sl.logAsHex("Logging hex number: ", 1234567);
    sl.logAsHex(1234567);
    sl.logAsBin("255 as binary: ", 255);
    sl.logAsBin(255);
    sl.logInt("Logging int: ", -1234567);
    sl.logLineDelimiter();
    sl.outdent();
  }
}