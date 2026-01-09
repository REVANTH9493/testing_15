#!/bin/bash
# scripts/build.sh
echo "=== DevOps Calculator Build ==="
echo "Build Number: ${BUILD_NUMBER:-local}"
echo ""
# Compile
echo "Compiling source files..."
find src -name "*.java" > sources.txt
javac @sources.txt
if [ $? -eq 0 ]; then
    echo "􀀀 Compilation successful"
else
    echo "􀀀 Compilation failed"
    exit 1
fi
# Run tests
echo ""
echo "Running tests..."
java -cp src/main/java:src/test/java com.devops.CalculatorTest
if [ $? -eq 0 ]; then
    echo "􀀀 All tests passed"
else
    echo "􀀀 Tests failed"
    exit 1
fi
# Create JAR
echo ""
echo "Creating JAR file..."
jar cfe calculator.jar com.devops.Calculator -C src/main/java .
echo "􀀀 Build completed successfully"
echo "JAR file: calculator.jar"