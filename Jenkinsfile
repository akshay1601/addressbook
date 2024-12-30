pipeline {
    agent none

    // tools {
    //     // Install the Maven version configured as "M3" and add it to the path.
    //     git  "gitpath"
    // }
    parameters {
        string(name: 'Env', defaultValue: 'Test', description: 'Version to deploy')

        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to run tc')

        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'], description: 'Pick something')

    }

    environment {
        Server1 = 'ubuntu@3.93.52.237'
        Server2 = 'ubuntu@3.93.52.237'
        Server3 = 'ubuntu@54.237.228.136'
        IMAGE_NAME = "akshayv1601/java_project"
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                script{
                    sshagent (credentials: ['Slave']) {
                        sh "scp -o StrictHostKeyChecking=no server1-config.sh ${Server1}:/home/ubuntu"
                        sh "ssh -o StrictHostKeyChecking=no ${Server1} 'bash ~/server1-config.sh'"
                     }
                }
            }

        }
        stage('UnitTest') {
            agent any
            when {
                expression {
                    params.executeTests == true
                }
            }
            steps {
                script{
                    sshagent (credentials: ['Slave']) {
                        sh "scp -o StrictHostKeyChecking=no server2-config.sh ${Server2}:/home/ubuntu"
                        sh "ssh -o StrictHostKeyChecking=no ${Server2} 'bash ~/server2-config.sh'"
                     }
                }
            }

        }
        // stage('Package') {
        //     agent any
        //     steps {
        //         script{
        //             sshagent (credentials: ['Slave']) {
        //                 sh "scp -o StrictHostKeyChecking=no server3-config.sh ${Server3}:/home/ubuntu"
        //                 sh "ssh -o StrictHostKeyChecking=no ${Server3} 'bash ~/server3-config.sh'"
        //              }
        //         }
        //     }

        // }
        stage('Deploy') {
            agent any
            input {
                message "Select the Version?"
                ok "Version Selected"
                parameters {
                    choice(name: 'PLATFORM', choices: ['EKS', 'ONPREM_EKS', 'ON_SERVER'], description: 'Pick something')
                }
            }
            steps{
                echo "Deploy the Code ${params.Env}"
                script{
                    sshagent (credentials: ['Slave']) {
                        withCredentials([usernamePassword(credentialsId: 'Docker-hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                        sh "scp -o StrictHostKeyChecking=no server3-config.sh ${Server3}:/home/ubuntu"
                        sh "ssh -o StrictHostKeyChecking=no ${Server3} 'bash ~/server3-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"
                        sh "ssh ${Server3} sudo docker login docker.io -u $username -p $password"
                        sh "ssh ${Server3} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                        
                        }
                    }
                }
            }
        }        
    }
}
