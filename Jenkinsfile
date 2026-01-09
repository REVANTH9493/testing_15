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
                    url: 'https://github.com/REVANTH9493/testing_15.git'
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
            steps {
                echo 'Tests already executed during build'
            }
        }


        stage('Package') {
            steps {
                sh """
                test -f calculator.jar
                mkdir -p package
        
                echo "version: ${params.VERSION}" > version.txt
                echo "build: ${BUILD_NUMBER}" >> version.txt
                echo "environment: ${params.ENVIRONMENT}" >> version.txt
        
                cp calculator.jar version.txt Dockerfile package/
                ls -la package/
                """
            }
        }


        stage('Deploy') {
            when {
                expression { params.ENVIRONMENT != 'dev' }
            }
            steps {
                sh '''
                echo "Deploying to ${params.ENVIRONMENT}"
                echo "Deployment started" > deploy.log
                date >> deploy.log
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
            archiveArtifacts artifacts: '**/*.txt', fingerprint: true
        }
    
        success {
            echo "DevOps workflow completed successfully"
        }
    
        failure {
            echo "DevOps workflow failed"
        }
    }

}
