// Copyright (c) Sui Calculator Challenge
// SPDX-License-Identifier: MIT

module calculator::calculator {
    use sui::object::{Self, UID};
    use sui::tx_context::{TxContext, sender};
    use sui::transfer::{self, public_transfer};

    /// Error codes
    const E_DIVISION_BY_ZERO: u64 = 1;
    const E_OVERFLOW: u64 = 2;

    /// Calculator object that stores calculation history
    public struct Calculator has key, store {
        id: UID,
        owner: address,
        last_result: u64,
        operation_count: u64,
    }

    /// Result object for individual calculations
    public struct CalculationResult has key, store {
        id: UID,
        operation: vector<u8>,
        operand_1: u64,
        operand_2: u64,
        result: u64,
    }

    /// Initialize a new calculator for the user
    public entry fun create_calculator(ctx: &mut TxContext) {
        let calculator = Calculator {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            last_result: 0,
            operation_count: 0,
        };
        transfer::public_transfer(calculator, tx_context::sender(ctx));
    }

    /// Add two numbers
    public entry fun add(calculator: &mut Calculator, a: u64, b: u64, ctx: &mut TxContext) {
        let result = a + b;
        calculator.last_result = result;
        calculator.operation_count = calculator.operation_count + 1;

        let calc_result = CalculationResult {
            id: object::new(ctx),
            operation: b"add",
            operand_1: a,
            operand_2: b,
            result,
        };
        transfer::public_transfer(calc_result, tx_context::sender(ctx));
    }

    /// Subtract two numbers
    public entry fun subtract(calculator: &mut Calculator, a: u64, b: u64, ctx: &mut TxContext) {
        assert!(a >= b, E_OVERFLOW);
        let result = a - b;
        calculator.last_result = result;
        calculator.operation_count = calculator.operation_count + 1;

        let calc_result = CalculationResult {
            id: object::new(ctx),
            operation: b"subtract",
            operand_1: a,
            operand_2: b,
            result,
        };
        transfer::public_transfer(calc_result, tx_context::sender(ctx));
    }

    /// Multiply two numbers
    public entry fun multiply(calculator: &mut Calculator, a: u64, b: u64, ctx: &mut TxContext) {
        let result = a * b;
        calculator.last_result = result;
        calculator.operation_count = calculator.operation_count + 1;

        let calc_result = CalculationResult {
            id: object::new(ctx),
            operation: b"multiply",
            operand_1: a,
            operand_2: b,
            result,
        };
        transfer::public_transfer(calc_result, tx_context::sender(ctx));
    }

    /// Divide two numbers
    public entry fun divide(calculator: &mut Calculator, a: u64, b: u64, ctx: &mut TxContext) {
        assert!(b != 0, E_DIVISION_BY_ZERO);
        let result = a / b;
        calculator.last_result = result;
        calculator.operation_count = calculator.operation_count + 1;

        let calc_result = CalculationResult {
            id: object::new(ctx),
            operation: b"divide",
            operand_1: a,
            operand_2: b,
            result,
        };
        transfer::public_transfer(calc_result, tx_context::sender(ctx));
    }

    /// Get last result from calculator
    public fun get_last_result(calculator: &Calculator): u64 {
        calculator.last_result
    }

    /// Get total operation count
    public fun get_operation_count(calculator: &Calculator): u64 {
        calculator.operation_count
    }

    /// Reset calculator
    public entry fun reset(calculator: &mut Calculator) {
        calculator.last_result = 0;
    }

    /// Power operation (a ^ b)
    public entry fun power(calculator: &mut Calculator, base: u64, exponent: u64, ctx: &mut TxContext) {
        let result = 1;
        let i = 0;
        while (i < exponent) {
            result = result * base;
            i = i + 1;
        };
        calculator.last_result = result;
        calculator.operation_count = calculator.operation_count + 1;

        let calc_result = CalculationResult {
            id: object::new(ctx),
            operation: b"power",
            operand_1: base,
            operand_2: exponent,
            result,
        };
        transfer::public_transfer(calc_result, tx_context::sender(ctx));
    }

    /// Modulo operation (a % b)
    public entry fun modulo(calculator: &mut Calculator, a: u64, b: u64, ctx: &mut TxContext) {
        assert!(b != 0, E_DIVISION_BY_ZERO);
        let result = a % b;
        calculator.last_result = result;
        calculator.operation_count = calculator.operation_count + 1;

        let calc_result = CalculationResult {
            id: object::new(ctx),
            operation: b"modulo",
            operand_1: a,
            operand_2: b,
            result,
        };
        transfer::public_transfer(calc_result, tx_context::sender(ctx));
    }

    /// Test function to verify calculator functionality
    #[test]
    fun test_addition() {
        use sui::test_scenario::{self, ctx};

        let admin = @0x1;
        let scenario_val = test_scenario::begin(admin);
        let scenario = &mut scenario_val;

        test_scenario::next_tx(test_scenario, admin);
        {
            let calculator = Calculator {
                id: object::new(ctx(test_scenario)),
                owner: admin,
                last_result: 0,
                operation_count: 0,
            };

            add(&mut calculator, 5, 3, ctx(test_scenario));
            assert!(get_last_result(&calculator) == 8, 0);

            transfer::public_transfer(calculator, admin);
        };

        test_scenario::end(scenario_val);
    }
}
