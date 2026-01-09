// Jenkinsfile
pipeline {
agent any
tools {
jdk 'jdk11'
}
parameters {
string(name: 'VERSION', defaultValue: '1.0.0', description: 'Application version')
choice(name: 'ENVIRONMENT', choices: ['dev', 'test', 'staging'], description: 'Deployment environment')
}
stages {
stage('Checkout') {
steps {
git branch: 'main',
url: 'file:///PATH/TO/YOUR/complete-devops-project'
echo "Checked out code for ${params.ENVIRONMENT} environment"
}
}
stage('Build') {
steps {
echo "Building version ${params.VERSION}"
sh 'chmod +x scripts/build.sh'
sh './scripts/build.sh'
}
}
stage('Test') {
parallel {
stage('Unit Tests') {
steps {
sh '''
echo "Running unit tests..."
java -cp src/main/java:src/test/java com.devops.CalculatorTest
'''
}
}
stage('Integration Test') {
steps {
sh '''
echo "Running integration test..."
# Simulate integration test
java -cp src/main/java com.devops.Calculator > /dev/null 2>&1 || true
echo "Integration test completed"
'''
}
}
}
}
stage('Package') {
    steps {
echo "Packaging application..."
sh '''
# Create version file
echo "version: ${params.VERSION}" > version.txt
echo "build: ${BUILD_NUMBER}" >> version.txt
echo "environment: ${params.ENVIRONMENT}" >> version.txt
# Create deployment package
mkdir -p package
cp calculator.jar package/
cp version.txt package/
cp Dockerfile package/
echo "Package contents:"
ls -la package/
'''
}
}
stage('Deploy') {
when {
expression { params.ENVIRONMENT != 'dev' }
}
steps {
echo "Deploying to ${params.ENVIRONMENT} environment"
sh '''
echo "Simulating deployment to ${params.ENVIRONMENT}"
echo "Deployment log:" > deploy.log
date >> deploy.log
echo "Environment: ${params.ENVIRONMENT}" >> deploy.log
echo "Version: ${params.VERSION}" >> deploy.log
cat deploy.log
'''
}
}
}
post {
always {
echo "=== Build Complete ==="
echo "Job: ${JOB_NAME}"
echo "Build: ${BUILD_NUMBER}"
echo "Version: ${params.VERSION}"
echo "Environment: ${params.ENVIRONMENT}"
archiveArtifacts artifacts: 'package/**', fingerprint: true
archiveArtifacts artifacts: '*.log', fingerprint: true
}
success {
echo "􀀀 DevOps workflow completed successfully!"
// In real scenario, send success notification
}
failure {
echo "􀀀 DevOps workflow failed!"
// In real scenario, send failure notification
}
}
}
