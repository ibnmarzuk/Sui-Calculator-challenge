# Sui Calculator Challenge

A simple calculator dApp built with Sui Move to demonstrate fundamental smart contract concepts.

## Features

- **Basic Arithmetic Operations**
  - Addition
  - Subtraction
  - Multiplication
  - Division
  - Modulo (remainder)
  - Power (exponentiation)

- **State Management**
  - Persistent calculator object with history
  - Tracks last result
  - Counts total operations

- **Error Handling**
  - Division by zero protection
  - Overflow protection for subtraction

- **Calculation History**
  - Each operation creates a `CalculationResult` object
  - Stores operation type, operands, and result

## Project Structure

```
sui-calculator/
├── Move.toml
├── sources/
│   └── calculator.move
└── README.md
```

## Smart Contract Overview

### Structs

1. **Calculator** (with `key` and `store` abilities)
   - `id: UID` - Unique identifier
   - `owner: address` - Calculator owner
   - `last_result: u64` - Last calculation result
   - `operation_count: u64` - Total operations performed

2. **CalculationResult** (with `key` and `store` abilities)
   - `id: UID` - Unique identifier
   - `operation: vector<u8>` - Operation name ("add", "subtract", etc.)
   - `operand_1: u64` - First number
   - `operand_2: u64` - Second number
   - `result: u64` - Calculation result

### Functions

**Entry Functions** (callable from transactions):
   - `create_calculator()` - Initialize a new calculator
   - `add()` - Add two numbers
   - `subtract()` - Subtract with overflow check
   - `multiply()` - Multiply two numbers
   - `divide()` - Divide with zero check
   - `power()` - Calculate exponentiation
   - `modulo()` - Get remainder
   - `reset()` - Reset calculator
   
**View Functions** (no-op, read-only):
   - `get_last_result()` - Retrieve last result
   - `get_operation_count()` - Get total operations

## Key Concepts Demonstrated

1. **Structs**: Multiple custom structs with different abilities
2. **Functions**: Entry functions for blockchain interactions and view functions for queries
3. **Object Ownership**: Calculator objects are owned by specific addresses
4. **Transfer**: Objects are transferred to users after creation
5. **Mutability**: Using `&mut` references to modify objects
6. **Error Handling**: Custom error codes with `assert!` macro
7. **Loops**: Implemented in the `power()` function
8. **Testing**: Unit test included using Sui's testing framework

## Installation & Setup

1. **Install Sui CLI**:
```bash
cargo install --locked --git https://github.com/MystenLabs/sui.git --branch testnet sui
```

2. **Clone the Repository**:
```bash
git clone https://github.com/ibnmarzuk/Sui-Calculator-challenge.git
cd Sui-Calculator-challenge
```

3. **Build the Project**:
```bash
sui move build
```

4. **Run Tests**:
```bash
sui move test
```

5. **Deploy to Testnet** (optional):
```bash
sui client publish --gas-budget 100000000
```

## Usage

After deploying the contract, you can interact with it using the Sui CLI or Sui Wallet:

### Create a Calculator
```bash
sui client call --function create_calculator \
  --package <PACKAGE_ID> \
  --module calculator \
  --gas-budget 10000000
```

### Perform Addition
```bash
sui client call --function add \
  --package <PACKAGE_ID> \
  --module calculator \
  --args <CALCULATOR_OBJECT_ID> 10 5 \
  --gas-budget 10000000
```

## Learning Objectives

This project covers:
- Struct definition with abilities (`key`, `store`)
- Entry functions for blockchain interactions
- View functions for querying state
- Mutable references (`&mut`)
- Object transfer and ownership
- Error handling with custom error codes
- Loop constructs (`while`)
- Unit testing with Sui's test framework
- Practical Move logic and control flow

## Contributing

Feel free to submit issues or pull requests to improve this project!

## License

MIT

## Author

[ibnmarzuk](https://github.com/ibnmarzuk) - Frontend Dev & Web3 Educator

---
Built for the Sui blockchain ecosystem!
