// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from "forge-std/Vm.sol";
import {slInternal} from "./SLInternal.sol";
import {slIndent} from "./SLIndent.sol";

library slFormat {
    function format(string memory message, uint256 number, uint256 decimalPlaces) pure internal returns(string memory) {
      return string.concat(
        message,
        format(number, decimalPlaces)
      );
    }

    function format(uint256 number, uint256 decimalPlaces) pure internal returns(string memory) {
      if (number == 0) {
        return "0";
      }

      string memory numberStr = slInternal.vm.toString(number); 
      uint256 numberLength = bytes(numberStr).length;
      if (decimalPlaces == 0) {
        return numberStr;
      }

      if(decimalPlaces == numberLength) {
        // number is less than 1
        return string.concat("0", slInternal.WholeNumberDelimiter, numberStr);
      } else if (decimalPlaces > numberLength) {
        // decimalPlaces is greater than number length, prefix with zeros
        uint256 leadingZeros = decimalPlaces - numberLength;
        string memory zeros = slInternal.duplicateString("0", leadingZeros);
        string memory zerosAndNumber = string.concat(zeros, numberStr);
        return slInternal.insertNumberDelimiter(zerosAndNumber, decimalPlaces, decimalPlaces);
      } 
      else {
        return slInternal.insertNumberDelimiter(numberStr, numberLength, decimalPlaces);
      }
    }

    function lineDelimiter() pure internal returns(string memory) {
      return slInternal.duplicateString("-", slInternal.LineLength);
    }

    function lineDelimiter(string memory message) pure internal returns(string memory) {
      uint256 strLength = bytes(message).length;
      uint256 padding = (slInternal.LineLength - strLength) / 2;
      uint256 align = strLength % 2 == 0 ? 1 : 0;
      return string.concat(
        slInternal.duplicateString("-", padding - align),  // leave some space 
        " ", message, " ",
        slInternal.duplicateString("-", padding - 1)
      );
    }
}