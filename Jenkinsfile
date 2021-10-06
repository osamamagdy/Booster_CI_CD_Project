pipeline {
    agent any

    stages {
        stage('CI') {
            steps {
                // Get some code from a GitHub repository
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {

                sh """
                docker ps -a -q | xargs --no-run-if-empty docker container rm -f
                docker build . -f dockerfile -t osamamagdy/django:latest
                docker login -u ${USERNAME}  -p ${PASSWORD}
                docker push osamamagdy/django:latest
                
                """

            }
}
        }
        
        
                stage('CD') {
            steps {

                sh """
                docker run -d -p 8000:8000 osamamagdy/django:latest
                
                """

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
             post {
                 success {
                     slackSend (color:"#00FF00", message: "Building success, notification by script")
                 }
                 failure {
                     slackSend (color:"#FF0000", message: "Building failure, notification by script")
                 }
           }
        }
    }
}