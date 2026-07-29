pipeline {
    agent any

    environment {
        TARGET_DIR = 'C:\\inetpub\\wwwroot\\my-web-app'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout Source') {
            steps {
                echo 'Checking out source code from SCM...'
                checkout scm
            }
        }

        stage('Pre-Build Validation') {
            steps {
                echo 'Running Windows Batch static validation...'
                bat 'call test-app.bat'
            }
        }

        stage('Deploy Application') {
            steps {
                echo 'Deploying application assets to Windows web root...'
                bat 'call deploy.bat'
            }
        }

        stage('Health Check') {
            steps {
                echo 'Verifying deployed application files...'
                bat 'if exist "%TARGET_DIR%\\index.html" (echo Health Check Passed) else (exit /b 1)'
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed and application deployed successfully!'
        }
        failure {
            echo 'Pipeline failed! Check console output for errors.'
        }
    }
}
