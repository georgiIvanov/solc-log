// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";

library SolcLogInternal {
    uint256 internal constant WAD = 1e18;
    uint256 internal constant LineLength = 80;

    address private constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))));
    Vm private constant vm = Vm(VM_ADDRESS);

    function format(string memory message, uint256 number, uint256 decimalPlaces) pure internal returns(string memory) {
        return string.concat(
          message, 
          vm.toString(number / decimalPlaces), 
          " ", 
          inParenthesis(number)
        );
    }

    function lineDelimiter() pure internal returns(string memory) {
        return duplicateString("-", LineLength);
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

    function inParenthesis(uint256 number) pure private returns(string memory) {
        return string.concat("(", vm.toString(number), ")");
    }
}