// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from "forge-std/Vm.sol";
import {console2} from "forge-std/console2.sol";

library slInternal {
    uint256 internal constant WAD = 18;
    uint256 internal constant LineLength = 60;
    string internal constant WholeNumberDelimiter = "-";
    string internal constant LogInset = "    ";
    string internal constant InsetCountKey = "sl.insetCount";

    address private constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))));
    Vm private constant vm = Vm(VM_ADDRESS);

    function _castReadU256ToPure(
        function(bytes memory) internal view returns (uint256) fnIn
    ) internal pure returns (function(bytes memory) internal pure returns (uint256) fnOut) {
        assembly {
            fnOut := fnIn
        }
    }

    function _sendReadU256Payload(bytes memory payload) internal pure returns (uint256) {
        return _castReadU256ToPure(_sendPayloadReadU256)(payload);
    }

    function _sendPayloadReadU256(bytes memory payload) private view returns (uint256) {
        uint256 payloadLength = payload.length;
        address vmAddress = VM_ADDRESS;
        /// @solidity memory-safe-assembly
        uint256 returnValue = 777;
        assembly {
          let payloadStart := add(payload, 32)
          let output := mload(0x40) // Get a free memory pointer
          let success := staticcall(gas(), vmAddress, payloadStart, payloadLength, output, 32)
          if iszero(success) {
            revert(0, 0)
          }

          let result := mload(output) // Load the returned uint256 value from memory to stack
          mstore(0x40, add(output, 32)) // Update the free memory pointer
          returnValue := result
        }

        return returnValue;
    }

    function _castSetEnv(
        function(bytes memory) internal view fnIn
    ) internal pure returns (function(bytes memory) internal pure fnOut) {
        assembly {
            fnOut := fnIn
        }
    }

    function _sendSetEnvPayload(bytes memory payload) internal pure  {
        return _castSetEnv(_sendPayloadSetEnv)(payload);
    }

    function _sendPayloadSetEnv(bytes memory payload) private view {
        uint256 payloadLength = payload.length;
        address vmAddress = VM_ADDRESS;
        /// @solidity memory-safe-assembly
        assembly {
            let payloadStart := add(payload, 32)
            let success := staticcall(gas(), vmAddress, payloadStart, payloadLength, 0, 0)
        }
    }

    function indent() internal pure returns (uint256){
      bytes memory payload = abi.encodeWithSignature("envOr(string,uint256)", InsetCountKey, 0);
      uint256 indentTimes = _sendReadU256Payload(payload) + 1;
      payload = abi.encodeWithSignature("setEnv(string,string)", InsetCountKey, vm.toString(indentTimes));
      _sendSetEnvPayload(payload);
      return indentTimes;
    }


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

    function insertNumberDelimiter(string memory number, uint256 numberLength, uint256 decimalPlaces) private pure returns(string memory) {
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