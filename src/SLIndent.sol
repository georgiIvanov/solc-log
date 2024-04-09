// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from "forge-std/Vm.sol";
import {console2} from "forge-std/console2.sol";
import {slInternal} from "./SLInternal.sol";

library slIndent {
    string internal constant LogInset = "    ";
    address internal constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))));

    // keccak256(abi.encode(uint256(keccak256("sl.key.indentCount")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 internal constant IndentCountSlot = 0x6fd4a1b467b35b28373811cbff53fcf35e519d446365ce4ab2db637641925200;

    /// @notice Conditionally applies indent to formatted string
    /// @dev applyIndent can be called multiple times during format, so we have to apply it conditionally
    /// @dev Should not be called directly by client code
    function applyIndent(string memory message, bool shouldIndent) pure internal returns(string memory) {
      return shouldIndent ? 
      string.concat(slInternal.duplicateString(LogInset, indentCount()), message) :
      message;
    }

    function indentCount() pure internal returns (uint256) {
      bytes memory payload = abi.encodeWithSignature("load(address,bytes32)", VM_ADDRESS, IndentCountSlot);
      return _readDataAtSlot(payload);
    }

    function indent() internal pure returns (uint256) {
      uint256 indentTimes = indentCount() + 1;
      bytes memory payload = abi.encodeWithSignature(
        "store(address,bytes32,bytes32)", VM_ADDRESS, IndentCountSlot, bytes32(indentTimes)
      );
      _storeDataAtSlot(payload);
      return indentTimes;
    }

    function outdent() internal pure returns (uint256) {
      uint256 currentIndent = indentCount();
      if (currentIndent == 0) {
        return 0;
      }

      uint256 indentTimes = currentIndent - 1;
      bytes memory payload = abi.encodeWithSignature(
        "store(address,bytes32,bytes32)", VM_ADDRESS, IndentCountSlot, bytes32(indentTimes)
      );
      _storeDataAtSlot(payload);
      return indentTimes;
    }

    function _castReadDataAtSlot(
        function(bytes memory) internal view returns (uint256) fnIn
    ) internal pure returns (function(bytes memory) internal pure returns (uint256) fnOut) {
      assembly {
          fnOut := fnIn
      }
    }

    function _readDataAtSlot(bytes memory payload) internal pure returns (uint256) {
      return _castReadDataAtSlot(_invokeReadDataAtSlot)(payload);
    }

    function _invokeReadDataAtSlot(bytes memory payload) private view returns (uint256 returnValue) {
      uint256 payloadLength = payload.length;
      address vmAddress = slInternal.VM_ADDRESS;
      assembly {
        let payloadStart := add(payload, 32)
        let output := mload(0x40) // Get a free memory pointer
        let success := staticcall(gas(), vmAddress, payloadStart, payloadLength, output, 32)
        if iszero(success) {
          revert(0, 0)
        }

        returnValue := mload(output) // Load the returned uint256 value from memory to stack
        mstore(0x40, add(output, 32)) // Update the free memory pointer
      }

      return returnValue;
    }

    function _castStoreDataAtSlot(
      function(bytes memory) internal view fnIn
    ) internal pure returns (function(bytes memory) internal pure fnOut) {
      assembly {
          fnOut := fnIn
      }
    }

    function _storeDataAtSlot(bytes memory payload) private pure  {
      return _castStoreDataAtSlot(_invokeStoreDataAtSlot)(payload);
    }

    function _invokeStoreDataAtSlot(bytes memory payload) internal view {
      uint256 payloadLength = payload.length;
      address vmAddress = slInternal.VM_ADDRESS;
      assembly {
        let payloadStart := add(payload, 32)
        let success := staticcall(gas(), vmAddress, payloadStart, payloadLength, 0, 0)
      }
    }
}