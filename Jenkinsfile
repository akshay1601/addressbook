pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "MyMaven"
    }
    parameters {
        string(name: 'Env', defaultValue: 'Test', description: 'Version to deploy')

        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to run tc')

        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'], description: 'Pick something')

    }

    environment {
        Server1 = 'ubuntu@3.84.119.88'
        Server2 = 'ubuntu@3.88.164.230'
        Server3 = 'ubuntu@3.95.182.107'
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                script{
                    sshagent (credentials: ['Slave1']) {
                        sh "scp -o StrictHostKeyChecking=no server1-comfig.sh ${Server1}:/home/ubuntu"
                        sh "ssh -o StrictHostKeyChecking=no ${Server1} 'bash ~/server1-comfig.sh'"
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
                    sshagent (credentials: ['Slave2']) {
                        sh "scp -o StrictHostKeyChecking=no server2-comfig.sh ${Server2}:/home/ubuntu"
                        sh "ssh -o StrictHostKeyChecking=no ${Server2} 'bash ~/server2-comfig.sh'"
                     }
                }
            }

        }
        stage('Package') {
            agent any
            steps {
                script{
                    sshagent (credentials: ['Slave3']) {
                        sh "scp -o StrictHostKeyChecking=no server3-config.sh ${Server3}:/home/ubuntu"
                        sh "ssh -o StrictHostKeyChecking=no ${Server3} 'bash ~/server3-config.sh'"
                     }
                }
            }

        }
        stage('Deploy') {
            input {
                message "Select the Version?"
                ok "Version Selected"
                parameters {
                    choice(name: 'PLATFORM', choices: ['EKS', 'ONPREM_EKS', 'ON_SERVER'], description: 'Pick something')
                }
            }
            steps{
                echo "Deploy the Code ${params.Env}"
            }
        }        
    }
}
