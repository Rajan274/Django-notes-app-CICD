
pipeline {
    agent any

    stages{
        stage("Code"){
            steps{
                echo "This is cloning the code"
                git url: "https://github.com/Rajan274/Django-notes-app-CICD.git" , branch: "main"
            }
        }
         stage("Build"){
            steps{
                echo "This is building the code"
                sh "docker build -t notes-app:latest ."
            }
        }
         stage("Pushing"){
            steps{
                echo "This is pushing the code"
                withCredentials([usernamePassword(
                    'credentialsId': 'django-app',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "docker login -u ${env.DOCKER_USER} -p ${env.DOCKER_PASS}"
                    sh "docker image tag notes-app:latest ${env.DOCKER_USER}/notes-app:latest"
                    sh "docker push ${env.DOCKER_USER}/notes-app:latest"
                    }
            }
        }
         stage("Deploy"){
            steps{
                echo "This is Deploy the code"
                 // sh 'docker compose down'
                 sh 'docker compose up -d --build'
            }
        }
    }
}
