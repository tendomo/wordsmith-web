pipeline {
    agent any
    tools {
        go 'Go' // Adjust based on your Go version
       
    }

    stages {
        stage('Build Go Web App') {
            steps {
               // sh 'go mod init wordweb'
                sh 'go build -o main ./' // Adjust command and output file
            }
        } 

        stage('Build Docker Image for Go Web App') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                 
                  sh 'docker login -u $USERNAME -p $PASSWORD'
                  sh 'docker build -t word-web:latest -f Dockerfile  --build-arg WEB_APP_PORT=8080 --build-arg JAVA_API_URL=http://java-api:8081 .'
                  sh 'docker tag word-web:latest tendomo/word-web:${BUILD_NUMBER}'
                  sh 'docker push tendomo/word-web:${BUILD_NUMBER}'
                                  
                }
            }
        }
    }
}