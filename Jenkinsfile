pipeline {
    agent any

    stages {
        stage('build image') {
            steps {
            sh """
               docker ps -aqf "name=django_dev"  | xargs --no-run-if-empty docker container rm -f
               docker build -t osamamagdy/django:dev .
            """    
            }
            post {
                success {
                     slackSend (color:"#00FF00", message: "Dev: Building Image success")
                }
                failure {
                     slackSend (color:"#FF0000", message: "Dev: Building Image failure")
                }
           }
        }
        
        
        stage('push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) 
                {
                sh """
                docker login -u ${USERNAME}  -p ${PASSWORD}
                docker push osamamagdy/django:dev
                """
                }
            }
            post {
                success {
                     slackSend (color:"#00FF00", message: "Dev: pushing image success")
                }
                failure {
                     slackSend (color:"#FF0000", message: "Dev: pushing image failure")
                }
           }
        }
        stage('deploy image') {
            steps {
            sh """
            docker run -d -p 8001:8000 --name=django_dev osamamagdy/django:dev        
            """
            }
            post {
                success {
                     slackSend (color:"#00FF00", message: "dev: deploying Image success")
                }
                failure {
                     slackSend (color:"#FF0000", message: "dev: deploying Image failure")
                }
           }
        }

    }
}