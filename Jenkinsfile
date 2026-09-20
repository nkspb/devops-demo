pipeline {
	agent any

	environment {
		IMAGE_TAG = "${BUILD_NUMBER}"
	}

	stages {
		stage('CI') {
			steps {
				withCredentials([
					usernamePassword(
						credentialsId: 'dockerhub-creds',
						usernameVariable: 'DOCKERHUB_USER',
						passwordVariable: 'DOCKERHUB_TOKEN'
					)
				]) {
					sh 'echo "Dockerhub user is: $DOCKERHUB_USER"'
					sh 'make ci IMAGE_TAG=$IMAGE_TAG'
				   }
			}
		}
		stage('Deploy to Kubernetes') {
			steps {
				sh '''
					kubectl set image deployment/devops-demo \
						devops-demo=nkom/devops-demo:$IMAGE_TAG
					kubectl rollout status deployment/devops-demo
				'''
			}
		}
	}
}
