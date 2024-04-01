// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from "forge-std/Vm.sol";
import {console2} from "forge-std/console2.sol";

library slIndent {
    string internal constant LogInset = "    ";
    string internal constant InsetCountKey = "sl.insetCount";

    address private constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))));
    Vm private constant vm = Vm(VM_ADDRESS);

    function indentCount() pure internal returns (uint256) {
        bytes memory payload = abi.encodeWithSignature("envOr(string,uint256)", InsetCountKey, 0);
        return _sendReadU256Payload(payload);
    }

    function indent() internal pure returns (uint256) {
      uint256 indentTimes = indentCount() + 1;
      bytes memory payload = abi.encodeWithSignature("setEnv(string,string)", InsetCountKey, vm.toString(indentTimes));
      _sendSetEnvPayload(payload);
      return indentTimes;
    }

    function outdent() internal pure returns (uint256) {
      uint256 indentTimes = indentCount() - 1;
      bytes memory payload = abi.encodeWithSignature("setEnv(string,string)", InsetCountKey, vm.toString(indentTimes));
      _sendSetEnvPayload(payload);
      return indentTimes;
    }

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

    function _sendPayloadReadU256(bytes memory payload) private view returns (uint256 returnValue) {
        uint256 payloadLength = payload.length;
        address vmAddress = VM_ADDRESS;
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
        assembly {
            let payloadStart := add(payload, 32)
            let success := staticcall(gas(), vmAddress, payloadStart, payloadLength, 0, 0)
        }
    }
}