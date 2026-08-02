pipeline {
	agent any

	environment {
		IMAGE_TAG = "${BUILD_NUMBER}"
	}

	stages {
		stage('CI') {
			steps {
				sh 'make ci IMAGE_TAG=$IMAGE_TAG'
			}
		}
	}
}
