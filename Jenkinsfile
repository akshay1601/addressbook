pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "MyMaven"
    }


    stages {
        stage('Compile') {
            agent {label 'Slave1'}
            steps {
                echo "Compile the code"
                sh 'mvn compile'
            }

        }
                stage('UnitTest') {
            agent{label 'Slave2'}
            steps {
                echo "Compile the code"
                sh 'mvn test'
            }

        }
                stage('Package') {
            agent{label 'Slave3'}
            steps {
                echo "Compile the code"
                sh 'mvn package'
            }

        }
    }
}
