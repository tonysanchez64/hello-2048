pipeline {
    agent any
    options{
	timestamps()
    }
    stages {

        stage('pacakge'){
            steps {
		sh 'docker-compose build'
                withCredentials([string(credentialsId: 'Token_Github', variable:'CR_PAT')]) {
                    sh 'echo $CR_PAT | docker login ghcr.io -u tonysanchez64 --password-stdin'
                }
		sh 'docker push ghcr.io/tonysanchez64/hello-2048/hello-2048:v1'
            }
        }
        stage('Build') {
            steps {
                sshagent(['ssh-amazon']) {
                    sh """
                        ssh -o "StrictHostKeyChecking no" ec2-user@34.255.205.246 docker pull ghcr.io/tonysanchez64/hello-2048/hello-2048:v1
                    """
	            sh 'ssh ec2-user@34.255.205.246 docker run -it --rm ghcr.io/tonysanchez64/hello-2048/hello-2048:v1'
                }        
            }
        }
          
    }
    
}
