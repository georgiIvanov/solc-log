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
import {SolcLog} from "solc-log/SolcLog.sol";
```

Make sure to add verbose logging to your command, example:
```bash
forge test --mc ContractName -vv
```

To avoid indentation issues, run only 1 test. See more details in **Tests** section.

## Testing

Due to the concurrent nature of the tests and the indent functionality depending on environment variables it is currently not possible to run all tests at once. The reason being is that indent env value is being used by multiple threads, causing tests to fail randomly.
