pipeline { 
    agent any 
    stages {
        stage('Build') {
            steps { 
                echo "--------Building site-----------------"
                echo "Create Build folder..." 
                sh 'mkdir build'
                echo "Execute build script..." 
                sh "chmod +x -R ${env.WORKSPACE}"
                sh "./make.sh"
                echo "Script executed successfully!"
                echo "Copying ready site to Build folder" 
                sh 'cp -r img build'
                sh 'cp -r lib build'
            }
        }
        stage('Deploy'){
            steps {
                echo "--------Deploying site-----------------"
                sshPublisher(
                    continueOnError: false, 
                    failOnError: true,
                    publishers: [
                        sshPublisherDesc(
                            configName: "apache",                             
                            verbose: true,
                            transfers: [
                                sshTransfer(cleanRemote: true, sourceFiles: "build/**",execCommand: "mv /var/www/html/build/* /var/www/html && rmdir /var/www/html/build/")
                            ]
                        )
                    ]
                )
            }
        }        
        stage('Test Site') {
            steps { 
                echo "--------Simply cURL of the site-----------------"
                script {
                    final String url = "3.21.54.71"
                    final String response = sh(script: "curl -s $url", returnStdout: true).trim()
                    echo response
                    final String emp = sh(script: 'echo response | grep "<title>Panorams</title>"', returnStdout: true).trim()
                    echo "Parsed title is $emp"
                    sh "echo emp"
                    echo emp
                    if (emp) {
                        sh "exit 1"
                    }
                }
            }
        }
    }
}
