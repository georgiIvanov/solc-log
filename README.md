# SolcLog

Logging library that **reduces** the time spent writing the same logging functions again and again.

### Features
- Numbers formatting
- Line delimiters
- Logs indentation
- Binary and hex representation of numbers

> See `SLConsole.t.sol` for examples

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

## TODO

- Log bytes, similar to console2.logBytes
- Parameterized indent / outdent
- Decimal places for bits, Q notation (X96 or X128). Example: `uint160 sqrtPriceX96 = Q64.X96` (whole part is 64 bits)
