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
        Server = 'ubuntu@3.83.153.6'
    }

    stages {
        // stage('Compile') {
        //     agent {label 'Slave1'}
        //     steps {
        //         echo "Compile the code ${params.Env}"
        //         sh 'mvn compile'
        //     }

        // }
        // stage('UnitTest') {
        //     agent{label 'Slave2'}
        //     when {
        //         expression {
        //             params.executeTests == true
        //         }
        //     }
        //     steps {
        //         echo "Compile the code"
        //         sh 'mvn test'
        //     }

        // }
        stage('Package') {
            agent any
            steps {
                script{
                    sshagent (credentials: ['Slave1']) {
                        sh "ssh -o StrictHostKeyChecking=no ${server}"
                        sh "sudo apt-get install maven -y"
                        sh "cd /home/ubuntu"
                        sh "git clone https://github.com/akshay1601/addressbook.git"
                        sh "cd addressbook"
                        sh "mvn package"
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
