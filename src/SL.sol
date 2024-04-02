// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console2} from "forge-std/console2.sol";
import {slFormat} from "./slFormat.sol";
import {slIndent} from "./slIndent.sol";
import {slInternal} from "./slInternal.sol";

library sl {
  using slFormat for string;
  using slFormat for uint256;

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
    console2.log(message.format(number, slInternal.WAD));
  }

  /// @notice Logs number with message
  /// Format is [message][whole part]-[decimal places]
  /// @param message The message to log
  /// @param number The number to format
  function log(string memory message, uint256 number, uint256 decimalPlaces) pure public {
    console2.log(message.format(number, decimalPlaces));
  }

  /// @notice Formats and logs number
  /// Format is [whole part]-[WAD]
  /// @param number The number to format
  function log(uint256 number) pure public {
    console2.log(number.format(slInternal.WAD));
  }

  /// @notice Formats and logs number
  /// Format is [whole part]-[decimal places]
  function log(uint256 number, uint256 decimalPlaces) pure public {
    console2.log(number.format(decimalPlaces));
  }

  /// @notice Logs line delimiter
  function logLineDelimiter() pure public {
    console2.log(slFormat.lineDelimiter());
  }

  /// @notice Logs line delimiter with message
  /// @param message The message to log
  function logLineDelimiter(string memory message) pure public {
    console2.log(message.lineDelimiter());
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

  function indent() pure public {
    slIndent.indent();
  }

  function outdent() pure public {
    slIndent.outdent();
  }
}