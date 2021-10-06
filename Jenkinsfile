pipeline {
    agent any

    stages {
        stage('build image') {
            steps {
            sh """
               docker ps -aqf "name=django_master"  | xargs --no-run-if-empty docker container rm -f
               docker build -t osamamagdy/django:master .
            """    
            }
            post {
                success {
                     slackSend (color:"#00FF00", message: "Master: Building Image success")
                }
                failure {
                     slackSend (color:"#FF0000", message: "Master: Building Image failure")
                }
           }
        }
        
        
        stage('push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) 
                {
                sh """
                docker login -u ${USERNAME}  -p ${PASSWORD}
                docker push osamamagdy/django:master
                """
                }
            }
            post {
                success {
                     slackSend (color:"#00FF00", message: "Master: pushing image success")
                }
                failure {
                     slackSend (color:"#FF0000", message: "Master: pushing image failure")
                }
           }
        }
        stage('deploy image') {
            steps {
            sh """
            docker run -d -p 8000:8000 --name=django_master osamamagdy/django:master        
            """
            }
            post {
                success {
                     slackSend (color:"#00FF00", message: "Master: deploying Image success")
                }
                failure {
                     slackSend (color:"#FF0000", message: "Master: deploying Image failure")
                }
           }
        }

    }
}