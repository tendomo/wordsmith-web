pipeline {
    agent any
    environment {
        CI = false
    }
    stages {
        stage('sonar analysis') {
            environment {
                scannerHome = tool 'SonarQube-Scanner'
            }
            steps {
                withsonarQubeScannerEnv('SonarQube-Scanner')
            }
        }
    
       // stage('test') {
           // steps {
              //  go 'Go' // Adjust based on your Go version 
           // }
        //}
    
        stage('Build Go Web App') {
            steps {
                //sh 'go mod init wordsmith-web2'
                sh 'go build -o main ./' // Adjust command and output file
            }
        } 

        stage('Build Docker Image for Go Web App') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                 
                  sh 'docker login -u $USERNAME -p $PASSWORD'
                  sh 'docker build -t word-web:latest -f Dockerfile .'
                  sh 'docker tag word-web:latest tendomo/word-web:${BUILD_NUMBER}'
                  sh 'docker push tendomo/word-web:${BUILD_NUMBER}'
                                  
                }
            }
        }
    }
}
