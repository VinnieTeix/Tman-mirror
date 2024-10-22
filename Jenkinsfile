pipeline {
    agent any

    environment {
        // GitHub repository details
        REPO_URL = 'git@github.com:VinnieTeix/Tman-mirror.git'
        // Docker Compose file location
        DOCKER_COMPOSE_FILE = './docker-compose.yml'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository
                git branch: 'main', url: "${env.REPO_URL}"
            }
        }

        stage('Build and Start Docker Containers') {
            steps {
                // Pull images and start up the containers
                script {
                    // Make sure docker-compose is present
                    sh 'docker-compose build'

                    // Run Docker Compose up in detached mode
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} up -d'
                }
            }
        }

        stage('Run Commands in Containers') {
            steps {
                script {
                    // List all the running Docker containers
                    sh 'docker ps'

                    // Run commands inside specific containers (container names from the compose file)
                    sh 'docker exec container_name_1 command_to_run_inside_container_1'
                    sh 'docker exec container_name_2 command_to_run_inside_container_2'
                }
            }
        }

        stage('Tear Down Docker Containers') {
            steps {
                script {
                    // Bring down the Docker containers after job completes
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} down'
                }
            }
        }
    }

    post {
        always {
            // Ensure containers are stopped even if the job fails
            script {
                sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} down || true'
            }
        }
    }
}
