pipeline {
    agent any

    environment {
        WEB_ROOT = '/var/www/html'
        APP_NAME = 'native-web-app'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {
        stage('Checkout SCM') {
            steps {
                echo 'Pulling source code from GitHub SCM...'
                checkout scm
            }
        }

        stage('Static Verification') {
            steps {
                echo 'Running static checks on workspace files...'
                sh './test-app.sh'
            }
        }

        stage('Deploy to Web Server') {
            steps {
                echo "Deploying application directly to host path: ${WEB_ROOT}..."
                sh """
                    # Copy web files to the host server document root
                    sudo cp index.html ${WEB_ROOT}/index.html
                    sudo chmod 644 ${WEB_ROOT}/index.html
                """
            }
        }

        stage('Health Check') {
            steps {
                echo 'Testing web server HTTP accessibility...'
                sh 'curl --fail http://localhost/ || exit 1'
            }
        }
    }

    post {
        success {
            echo "Pipeline Build #${BUILD_NUMBER} Deployed Successfully!"
        }
        failure {
            echo "Pipeline Build #${BUILD_NUMBER} Failed! Check console output for errors."
        }
    }
}
