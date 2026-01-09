package com.devops;
public class CalculatorTest {
    public static void main(String[] args) {
        Calculator calc = new Calculator();
        int passed = 0;
        int failed = 0;
    // Test addition
        try {
            int result = calc.add(5, 3);
            if (result == 8) {
                System.out.println("􀀀 Addition test passed");
                passed++;
            } else {
                System.out.println("􀀀 Addition test failed");
                failed++;
            }
        } catch (Exception e) {
            System.out.println("􀀀 Addition test error: " + e.getMessage());
            failed++;
        }
        // Test division with zero
        try {
            double result = calc.divide(5, 0);
            System.out.println("􀀀 Division by zero test failed - should have thrown exception");
            failed++;
        } catch (ArithmeticException e) {
            System.out.println("􀀀 Division by zero test passed");
            passed++;
        }
        System.out.println("\n=== Test Summary ===");
        System.out.println("Passed: " + passed);
        System.out.println("Failed: " + failed);
        System.out.println("Total: " + (passed + failed));
        if (failed > 0) {
            System.exit(1);
        }
    }
}