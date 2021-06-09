pipeline { 
    agent any 
    stages {
        stage('Cleanup') {
            steps {
                echo "--------Cleaning up old build files-----------------"
                sh '''
                    if ! [ -d build/ ]; then
                      mkdir build
                    else
                      rm build/*
                    fi
                '''
            }
        }
        stage('Build') {
            steps { 
                echo "--------Building site-----------------"
                echo "Execute build script..." 
                sh "./make.sh"
                echo "Script executed successfully!"
                echo "Copying ready site to Build folder" 
                sh 'cp img build'
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
                            configName: "3.21.54.71",                             
                            verbose: true ,
                            sshTransfer(execCommand: "if [ -d 'img' ]; then ls img; fi"),
                            sshTransfer(execCommand: "cp -r build/img /var/www/html/")
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
