# SolcLog

Logging helper library that reduces the time spent writing the same logging functions again and again.

It is a temporary tool to understand codebases and **not designed** to include in production code.

Features:
- Numbers formatting
- Line delimiters
- Stateful logs indentation

## Usage

Install it as a dependency:
```bash
forge install git@github.com:georgiIvanov/solc-log.git
```

Update `remappings.txt`:
```bash
solc-log/=lib/solc-log/src/
```

Import logging library:
```sol
import {sl} from "solc-log/sl.sol";
```

Make sure to add verbose logging to your command, example:
```bash
forge test --mc ContractName -vv
```

## Testing

To run all tests:
```bash
forge test -vv
```

## Troubleshooting

1. If you don't see logs, make sure you are running a normal unit test.
Currently Forge does not support logging in fuzz tests.
2. Does not work with hardhat traces.
