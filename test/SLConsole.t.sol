// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@src/SL.sol";

contract SLConsoleTest is Test {
  function testPrintNumbersInDifferentDenominations() view public {
    sl.logLineDelimiter("Some examples");
    sl.log("Logs from:", address(this));
    sl.log("number: ", 123 ether);
    sl.log("number: ", 123 * 1e6, 1e6); // USDC denomination
    sl.logLineDelimiter();
  }
}