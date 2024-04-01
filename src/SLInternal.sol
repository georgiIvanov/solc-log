// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from "forge-std/Vm.sol";

library slInternal {
    uint256 internal constant WAD = 18;
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

      string memory numberStr = vm.toString(number); 
      uint256 numberLength = bytes(numberStr).length;
      if (decimalPlaces == 0) {
        return numberStr;
      }

      if(decimalPlaces == numberLength) {
        // number is less than 1
        return string.concat("0", WholeNumberDelimiter, numberStr);
      } else if (decimalPlaces > numberLength) {
        // decimalPlaces is greater than number length, prefix with zeros
        uint256 leadingZeros = decimalPlaces - numberLength;
        string memory zeros = duplicateString("0", leadingZeros);
        string memory zerosAndNumber = string.concat(zeros, numberStr);
        return insertNumberDelimiter(zerosAndNumber, decimalPlaces, decimalPlaces);
      } 
      else {
        return insertNumberDelimiter(numberStr, numberLength, decimalPlaces);
      }
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

    function insertNumberDelimiter(string memory number, uint256 numberLength, uint256 decimalPlaces) public pure returns(string memory) {
      if (decimalPlaces == numberLength) {
        // number is less than 1
        return string.concat("0", WholeNumberDelimiter, number);
      }

      uint256 newLength = numberLength + 1;
      bytes memory result = new bytes(newLength);
      bytes memory strBytes = bytes(number);
      
      for (uint256 i; i < newLength; ++i) {
        if (i + decimalPlaces == numberLength) {
          result[i] = bytes(WholeNumberDelimiter)[0];
        } else if (i + decimalPlaces > numberLength) {
          result[i] = strBytes[i - 1]; // i-1 because we added a char
        } else {
          result[i] = strBytes[i]; // copy all before delimiter char
        }
      }

      return string(result);
    }
      

    function duplicateString(string memory str, uint256 times) private pure returns (string memory) {
        string memory result;
        for (uint256 i; i < times; ++i) {
            result = string.concat(result, str);
        }
        return result;
    }

    // Deprecated, to remove
    function removeFirstNChars(string memory str, uint256 n) private pure returns (string memory) {
      uint256 strLength = bytes(str).length;
      if (strLength == n) {
        return str;
      }
      require(bytes(str).length > n, "String length is less than N");

      bytes memory strBytes = bytes(str);
      bytes memory result = new bytes(strBytes.length - n);

      for (uint256 i = n; i < strBytes.length; ++i) {
        result[i - n] = strBytes[i];
      }

      return string(result);
    }
}