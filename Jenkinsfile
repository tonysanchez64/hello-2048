pipeline {
    agent any
    options{
	timestamps()
    }
    stages {
	stage('build'){
	    steps{
		sh 'docker-compose build'
		sh 'docker tag ghcr.io/tonysanchez64/hello-2048/hello-2048:latest ghcr.io/tonysanchez64/hello-2048/hello-2048:1.0.${BUILD_NUMBER}'
		sh 'git tag 1.0.${BUILD_NUMBER}'
		sshagent(['ssh-github']) {
			sh "git push --tags"
		}
	   }
	}
        stage('pacakge'){
            steps {
                withCredentials([string(credentialsId: 'Token_Github', variable:'CR_PAT')]) {
                    sh 'echo $CR_PAT | docker login ghcr.io -u tonysanchez64 --password-stdin'
                }
		sh 'docker push ghcr.io/tonysanchez64/hello-2048/hello-2048:1.0.${BUILD_NUMBER}'
            }
        }
        stage('deploy') {
            steps {
                sshagent(['ssh-amazon']) {
			sh 'ssh -o "StrictHostKeyChecking no" ec2-user@34.255.205.246 docker-compose -f ./hello-2048/docker-compose.yml pull'
                        sh 'ssh ec2-user@34.255.205.246 docker-compose -f ./hello-2048/docker-compose.yml up -d'

                }        
            }
        }
          
    }
    
}
