// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/console.sol";
import "./SolcLogInternal.sol";

library SolcLog {
  uint256 internal constant WAD = 1e18;

  /// @notice Logs number with message
  /// Format is [message] [number divided by WAD] [number]
  /// @param message The message to log
  /// @param number The number to log
  function log(string memory message, uint256 number) view public {
    console.log(SolcLogInternal.format(message, number, WAD));
  }

  /// @notice Logs number with message
  /// Format is [message] [number divided by decimalPlaces] [number]
  /// @param message The message to log
  /// @param number The number to log
  function log(string memory message, uint256 number, uint256 decimalPlaces) view public {
    console.log(SolcLogInternal.format(message, number, decimalPlaces));
  }
}