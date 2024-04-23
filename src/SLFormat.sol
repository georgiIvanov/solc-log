// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {slInternal} from "./SLInternal.sol";
import {slIndent} from "./SLIndent.sol";

library slFormat {
  using slIndent for string;

  function format(string memory message, int256 number, uint256 decimalPlaces) pure internal returns(string memory) {
    string memory fmtNumber = _format(slInternal.abs(number), decimalPlaces, false);
    string memory fmtNumberSign = number >= 0 ? fmtNumber : string.concat("-", fmtNumber);
    return string.concat(message, fmtNumberSign).applyIndent(true);
  }

  function formatAsBinary(uint256 number) pure internal returns(string memory) {
    return _convertToBinary(number).applyIndent(true);
  }

  function formatAsBinary(string memory message, uint256 number) pure internal returns(string memory) {
    return string.concat(
      message,
      _convertToBinary(number)
    ).applyIndent(true);
  }

  function _convertToBinary(uint256 number) pure private returns(string memory) {
    if (number == 0) {
      return "0";
    }
        
    bytes memory bstr = new bytes(256);
    uint256 k = 256;
    
    while (number != 0) {
      bstr[--k] = (number & 1 == 1) ? bytes1('1') : bytes1('0');
      number >>= 1;
    }
    
    // Truncate the empty entries of the array
    bytes memory bresult = new bytes(256 - k);
    for (uint256 i = 0; i < 256 - k; i++) {
        bresult[i] = bstr[k + i];
    }
    
    return string(bresult);
  }

  function format(string memory message) pure internal returns(string memory) {
    return message.applyIndent(true);
  }

  /// @notice Converts number to hex string with message prefix and applies indent
  function format(string memory message, bytes32 value) pure internal returns(string memory) {
    return string.concat(
      message,
      slInternal.vm.toString(value)
    ).applyIndent(true);
  }

  /// @notice Converts number to hex string and applies indent
  function format(bytes32 value) pure internal returns(string memory) {
    return slInternal.vm.toString(value).applyIndent(true);
  }

  function format(address addr) pure internal returns(string memory) {
    return slInternal.vm.toString(addr).applyIndent(true); 
  }

  function format(string memory message, address addr) pure internal returns(string memory) {
    return string.concat(
      message,
      slInternal.vm.toString(addr)
    ).applyIndent(true);
  }

  function format(string memory message, uint256 number, uint256 decimalPlaces) pure internal returns(string memory) {
    return string.concat(
      message,
      _format(number, decimalPlaces, false)
    ).applyIndent(true);
  }
  function format(uint256 number, uint256 decimalPlaces) pure internal returns(string memory) {
    return _format(number, decimalPlaces, true);
  }
  function _format(uint256 number, uint256 decimalPlaces, bool shouldIndent) pure private returns(string memory) {
    if (number == 0) {
      return string("0").applyIndent(shouldIndent);
    }

    string memory numberStr = slInternal.vm.toString(number); 
    uint256 numberLength = bytes(numberStr).length;
    if (decimalPlaces == 0) {
      return numberStr.applyIndent(shouldIndent);
    }

    if(decimalPlaces == numberLength) {
      // number is less than 1
      return string.concat("0", slInternal.WholeNumberDelimiter, numberStr).applyIndent(shouldIndent);
    } else if (decimalPlaces > numberLength) {
      // decimalPlaces is greater than number length, prefix with zeros
      uint256 leadingZeros = decimalPlaces - numberLength;
      string memory zeros = slInternal.duplicateString("0", leadingZeros);
      string memory zerosAndNumber = string.concat(zeros, numberStr);
      return slInternal.insertNumberDelimiter(zerosAndNumber, decimalPlaces, decimalPlaces).applyIndent(shouldIndent);
    } 
    else {
      return slInternal.insertNumberDelimiter(numberStr, numberLength, decimalPlaces).applyIndent(shouldIndent);
    }
  }

  function lineDelimiter() pure internal returns(string memory) {
    return slInternal.duplicateString("-", slInternal.LineLength).applyIndent(true);
  }

  function lineDelimiter(string memory message) pure internal returns(string memory) {
    uint256 strLength = bytes(message).length;
    uint256 padding = (slInternal.LineLength - strLength) / 2;
    uint256 align = strLength % 2 == 0 ? 1 : 0;
    return string.concat(
      slInternal.duplicateString("-", padding - align),  // leave some space 
      " ", message, " ",
      slInternal.duplicateString("-", padding - 1)
    ).applyIndent(true);
  }
}