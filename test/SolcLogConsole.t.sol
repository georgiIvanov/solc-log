// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@src/SolcLog.sol";

contract SolcLogConsoleTest is Test {
  function testPrintNumbersInDifferentDenominations() view public {
    SolcLog.logLineDelimiter("Some examples");
    SolcLog.log("Logs from:", address(this));
    SolcLog.log("number: ", 123 ether);
    SolcLog.log("number: ", 123 * 1e6, 1e6); // USDC denomination
    SolcLog.logLineDelimiter();
  }
}