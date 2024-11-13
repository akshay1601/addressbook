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


    stages {
        stage('Compile') {
            agent {label 'Slave1'}
            steps {
                echo "Compile the code ${params.Env}"
                sh 'mvn compile'
            }

        }
                stage('UnitTest') {
            agent{label 'Slave2'}
            when {
                expression {
                    params.executeTests == true
                }
            }
            steps {
                echo "Compile the code"
                sh 'mvn test'
            }

        }
                stage('Package') {
            agent{label 'Slave3'}
            steps {
                echo "Compile the code ${params.Env}"
                sh 'mvn package'
            }

        }
    }
}
