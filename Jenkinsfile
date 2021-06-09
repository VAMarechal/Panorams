pipeline { 
    agent any 
    stages {
        stage('Cleanup') {
            steps {
                echo "--------Cleaning up old build files-----------------"
                sh '''
                      if [ -d "build" ]; then rm -Rf build; fi
                      mkdir build
                '''
            }
        }
        stage('Build') {
            steps { 
                echo "--------Building site-----------------"
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
                                sshTransfer(sourceFiles: "build/img",),
                                sshTransfer(execCommand: "cp -r * /var/www/html")
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
                }
            }
        }
    }
}
