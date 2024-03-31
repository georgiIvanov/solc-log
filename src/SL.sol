// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console2} from "forge-std/console2.sol";
import "./slInternal.sol";

library sl {
  /// @notice Logs a message
  /// Format is [message]
  /// @param message The message to log
  function log(string memory message) pure public {
    console2.log(message);
  }

  /// @notice Logs number with message
  /// Format is [message] [whole part]-[WAD]
  /// @param message The message to log
  /// @param number The number to format
  function log(string memory message, uint256 number) pure public {
    console2.log(slInternal.format(message, number, slInternal.WAD));
  }

  /// @notice Logs number with message
  /// Format is [message][whole part]-[decimal places]
  /// @param message The message to log
  /// @param number The number to format
  function log(string memory message, uint256 number, uint256 decimalPlaces) pure public {
    console2.log(slInternal.format(message, number, decimalPlaces));
  }

  /// @notice Formats and logs number
  /// Format is [whole part]-[WAD]
  /// @param number The number to format
  function log(uint256 number) pure public {
    console2.log(slInternal.format(number, slInternal.WAD));
  }

  /// @notice Formats and logs number
  /// Format is [whole part]-[decimal places]
  function log(uint256 number, uint256 decimalPlaces) pure public {
    console2.log(slInternal.format(number, decimalPlaces));
  }

  /// @notice Logs line delimiter
  function logLineDelimiter() pure public {
    console2.log(slInternal.lineDelimiter());
  }

  /// @notice Logs line delimiter with message
  /// @param message The message to log
  function logLineDelimiter(string memory message) pure public {
    console2.log(slInternal.lineDelimiter(message));
  }

  /// @notice Logs an address
  function log(address addr) pure public {
    console2.log(addr);
  }

  /// @notice Logs an address with message prefix
  /// Format is [message][address]
  function log(string memory message, address addr) pure public {
    console2.log(message, addr);
  }
}