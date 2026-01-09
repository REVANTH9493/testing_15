#!/bin/bash
set -e

echo "=== DevOps Calculator Build ==="
echo "Build Number: ${BUILD_NUMBER}"

# Create output directory
mkdir -p target/classes

echo "Compiling source files..."
javac -d target/classes \
  src/main/java/com/devops/Calculator.java \
  src/test/java/com/devops/CalculatorTest.java

echo "Compilation successful"

echo "Running tests..."
java -cp target/classes com.devops.CalculatorTest

echo "All tests passed"

echo "Creating JAR..."
jar cf calculator.jar -C target/classes .

echo "Build completed successfully"
