pipeline {
    agent {dockerfile true}

    environment {
        // Define Docker Hub credentials
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'  // Jenkins ID for Docker Hub credentials
        DOCKER_IMAGE = 'your-dockerhub-username/your-repo' // Docker Hub repository name
        DOCKER_TAG = "${env.BUILD_NUMBER}" // Build number as the image tag
    }

    stages {
        stage('Build') {
            steps {

            }
        }
    }
}
