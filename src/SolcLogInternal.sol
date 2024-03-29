// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";

library SolcLogInternal {
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

    
    function inParenthesis(uint256 number) pure private returns(string memory) {
        return string.concat("(", vm.toString(number), ")");
    }
}