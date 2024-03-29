# SolcLog

Logging helper library that reduces the time spent writing the same logging functions again and again.

Features:
- Numbers formatting
- Line delimiters

## Usage

Install it as a dependency:
`forge install git@github.com:georgiIvanov/solc-log.git`

Update `remappings.txt`:
`solc-log/=lib/solc-log/src/`

Import logging library:
`import {SolcLog} from "solc-log/SolcLog.sol";`

Make sure to add verbose logging to your command, example:
`forge test -vv`