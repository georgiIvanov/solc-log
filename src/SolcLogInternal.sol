// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from "forge-std/Vm.sol";

library SolcLogInternal {
    uint256 internal constant WAD = 1e18;
    uint256 internal constant LineLength = 60;
    string internal constant WholeNumberDelimiter = "-";

    address private constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))));
    Vm private constant vm = Vm(VM_ADDRESS);

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

      string memory wholeNumber = vm.toString(number / decimalPlaces);
      return string.concat(
        wholeNumber,
        WholeNumberDelimiter,
        removeFirstNChars(vm.toString(number), bytes(wholeNumber).length)
      );
    }

    function lineDelimiter() pure internal returns(string memory) {
      return duplicateString("-", LineLength);
    }

    function lineDelimiter(string memory message) pure internal returns(string memory) {
      uint256 strLength = bytes(message).length;
      uint256 padding = (LineLength - strLength) / 2;
      uint256 align = strLength % 2 == 0 ? 1 : 0;
      return string.concat(
        duplicateString("-", padding - align),  // leave some space 
        " ", message, " ",
        duplicateString("-", padding - 1)
      );
    }

    /*//////////////////////////////////////////////////////////////
                                PRIVATE
    //////////////////////////////////////////////////////////////*/

    function duplicateString(string memory str, uint256 times) private pure returns (string memory) {
        string memory result;
        for (uint256 i; i < times; ++i) {
            result = string.concat(result, str);
        }
        return result;
    }

    function removeFirstNChars(string memory str, uint256 n) private pure returns (string memory) {
      require(bytes(str).length > n, "String length is less than N");

      bytes memory strBytes = bytes(str);
      bytes memory result = new bytes(strBytes.length - n);

      for (uint256 i = n; i < strBytes.length; ++i) {
        result[i - n] = strBytes[i];
      }

      return string(result);
    }
}