pipeline {
    agent any

    environment {
        APP_NAME = 'single-page-web-app'
        APP_PORT = '8081'
        IMAGE_TAG = "v1.0.${BUILD_NUMBER}"
    }

    options {
        timeout(time: 15, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout SCM') {
            steps {
                echo 'Checking out source code from GitHub...'
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image: ${APP_NAME}:${IMAGE_TAG}..."
                sh "docker build -t ${APP_NAME}:${IMAGE_TAG} -t ${APP_NAME}:latest ."
            }
        }

        stage('Deploy Container') {
            steps {
                echo 'Deploying application container...'
                sh """
                    # Stop and remove previous container instance if exists
                    docker stop ${APP_NAME}-container || true
                    docker rm ${APP_NAME}-container || true

                    # Run new container
                    docker run -d \\
                        -p ${APP_PORT}:80 \\
                        --name ${APP_NAME}-container \\
                        --restart unless-stopped \\
                        ${APP_NAME}:${IMAGE_TAG}
                """
            }
        }

        stage('Health Check') {
            steps {
                echo 'Validating deployment health...'
                sleep time: 3, unit: 'SECONDS'
                sh """
                    curl --fail http://localhost:${APP_PORT} || (echo "Health check failed!" && exit 1)
                """
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully! Application is live at http://localhost:${APP_PORT}"
        }
        failure {
            echo "Pipeline execution failed. Rolling back or inspecting logs required."
        }
        always {
            cleanWs() // Workspace hygiene post-build
        }
    }
}
