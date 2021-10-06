pipeline {
    agent any

    stages {
        stage('build image') {
            steps {
            sh """
            docker ps -a -q | xargs --no-run-if-empty docker container rm -f
            docker build -t osamamagdy/django:latest .
            """    
            }
            post {
                success {
                     slackSend (color:"#00FF00", message: "Building Image success")
                }
                failure {
                     slackSend (color:"#FF0000", message: "Building Image failure")
                }
           }
        }
        
        
        stage('push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) 
                {
                sh """
                docker login -u ${USERNAME}  -p ${PASSWORD}
                docker push osamamagdy/django:latest
                """
                }
            }
            post {
                success {
                     slackSend (color:"#00FF00", message: "pushing image success")
                }
                failure {
                     slackSend (color:"#FF0000", message: "pushing image failure")
                }
           }
        }
        stage('deploy image') {
            steps {
            sh """
            docker run -d -p 8000:8000 osamamagdy/django:latest        
            """    
            }
            post {
                success {
                     slackSend (color:"#00FF00", message: "deploying Image success")
                }
                failure {
                     slackSend (color:"#FF0000", message: "deploying Image failure")
                }
           }
        }

    }
}