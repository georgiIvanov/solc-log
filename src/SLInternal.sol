// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from "forge-std/Vm.sol";

library slInternal {
    uint256 internal constant WAD = 18;
    uint256 internal constant LineLength = 60;
    string internal constant WholeNumberDelimiter = "-";

    address internal constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))));
    Vm internal constant vm = Vm(VM_ADDRESS);

    /*//////////////////////////////////////////////////////////////
                                PRIVATE
    //////////////////////////////////////////////////////////////*/

    function insertNumberDelimiter(string memory number, uint256 numberLength, uint256 decimalPlaces) internal pure returns(string memory) {
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
      

    function duplicateString(string memory str, uint256 times) internal pure returns (string memory) {
        string memory result;
        for (uint256 i; i < times; ++i) {
            result = string.concat(result, str);
        }
        return result;
    }

    // Deprecated, to remove
    function removeFirstNChars(string memory str, uint256 n) internal pure returns (string memory) {
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