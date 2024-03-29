// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import "./SolcLogInternal.sol";
// TODO: Rename SolcLog to sl for brevity
library SolcLog {
  /// @notice Logs a message
  /// Format is [message]
  /// @param message The message to log
  function log(string memory message) view public {
    console.log(message);
  }

  /// @notice Logs number with message
  /// Format is [message] [number divided by WAD] [number]
  /// @param message The message to log
  /// @param number The number to log
  function log(string memory message, uint256 number) view public {
    console.log(SolcLogInternal.format(message, number, SolcLogInternal.WAD));
  }

  /// @notice Logs number with message
  /// Format is [message] [number divided by decimalPlaces] [number]
  /// @param message The message to log
  /// @param number The number to log
  function log(string memory message, uint256 number, uint256 decimalPlaces) view public {
    console.log(SolcLogInternal.format(message, number, decimalPlaces));
  }

  /// @notice Logs line delimiter
  function logLineDelimiter() view public {
    console.log(SolcLogInternal.lineDelimiter());
  }

  /// @notice Logs line delimiter with message
  /// @param message The message to log
  function logLineDelimiter(string memory message) view public {
    console.log(SolcLogInternal.lineDelimiter(message));
  }

  /// @notice Logs an address
  function log(address addr) view public {
    console.log(addr);
  }

  /// @notice Logs an address with message prefix
  function log(string memory message, address addr) view public {
    console.log(message, addr);
  }
}