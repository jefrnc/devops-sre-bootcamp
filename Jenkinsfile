// Jenkins Pipeline for Journal Management System
// This pipeline handles CI/CD for the bootcamp application

def APP_NAME = 'journals-app'
def DOCKER_REGISTRY = 'your-registry.com'
def ENVIRONMENTS = ['staging', 'production']

pipeline {
    agent {
        label 'bootcamp-slave'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 1, unit: 'HOURS')
        timestamps()
    }

    environment {
        MAVEN_OPTS = '-Xmx1024m -XX:MaxPermSize=256m'
        DOCKER_IMAGE = "${DOCKER_REGISTRY}/${APP_NAME}"
        BUILD_VERSION = "${env.BUILD_NUMBER}-${env.GIT_COMMIT.take(7)}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                script {
                    env.GIT_COMMIT_MSG = sh(
                        script: 'git log -1 --pretty=%B',
                        returnStdout: true
                    ).trim()
                }
            }
        }

        stage('Build & Test') {
            steps {
                dir('Code') {
                    sh '''
                        echo "Building application..."
                        mvn clean compile
                        
                        echo "Running unit tests..."
                        mvn test
                        
                        echo "Packaging application..."
                        mvn package
                    '''
                }
            }
            post {
                always {
                    junit 'Code/target/surefire-reports/*.xml'
                    archiveArtifacts artifacts: 'Code/target/*.jar', fingerprint: true
                }
            }
        }

        stage('Code Quality') {
            when {
                branch 'master'
            }
            steps {
                dir('Code') {
                    sh '''
                        echo "Running code quality checks..."
                        mvn sonar:sonar \
                            -Dsonar.projectKey=${APP_NAME} \
                            -Dsonar.host.url=${SONAR_URL} \
                            -Dsonar.login=${SONAR_TOKEN} || true
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                        echo "Building Docker image..."
                        docker build -t ${APP_NAME}:${BUILD_VERSION} .
                        docker tag ${APP_NAME}:${BUILD_VERSION} ${APP_NAME}:latest
                    '''
                }
            }
        }

        stage('Push to Nexus') {
            when {
                branch 'master'
            }
            steps {
                script {
                    // Push Maven artifacts
                    dir('Code') {
                        sh '''
                            mvn deploy \
                                -DaltDeploymentRepository=nexus::default::${NEXUS_URL}/repository/maven-releases/
                        '''
                    }
                    
                    // Push Docker image
                    sh '''
                        docker tag ${APP_NAME}:${BUILD_VERSION} ${DOCKER_IMAGE}:${BUILD_VERSION}
                        docker tag ${APP_NAME}:${BUILD_VERSION} ${DOCKER_IMAGE}:latest
                        docker push ${DOCKER_IMAGE}:${BUILD_VERSION}
                        docker push ${DOCKER_IMAGE}:latest
                    '''
                }
            }
        }

        stage('Deploy to Staging') {
            when {
                branch 'master'
            }
            steps {
                script {
                    deployToEnvironment('staging')
                }
            }
            post {
                success {
                    echo "Deployment to staging successful"
                }
            }
        }

        stage('Smoke Tests') {
            when {
                branch 'master'
            }
            steps {
                script {
                    runSmokeTests('staging')
                }
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'master'
            }
            input {
                message "Deploy to production?"
                ok "Deploy"
                parameters {
                    choice(
                        name: 'DEPLOYMENT_TYPE',
                        choices: ['Blue-Green', 'Rolling', 'Canary'],
                        description: 'Select deployment strategy'
                    )
                }
            }
            steps {
                script {
                    deployToEnvironment('production', params.DEPLOYMENT_TYPE)
                }
            }
            post {
                success {
                    slackSend(
                        color: 'good',
                        message: "Production deployment successful: ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
                    )
                }
                failure {
                    slackSend(
                        color: 'danger',
                        message: "Production deployment failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
                    )
                }
            }
        }
    }

    post {
        always {
            cleanWs()
            sh 'docker system prune -f'
        }
        success {
            echo "Pipeline completed successfully"
        }
        failure {
            emailext(
                subject: "Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "Build failed. Check console output at ${env.BUILD_URL}",
                to: '${DEFAULT_RECIPIENTS}'
            )
        }
    }
}

// Deployment function
def deployToEnvironment(environment, strategy = 'Rolling') {
    echo "Deploying to ${environment} using ${strategy} strategy..."
    
    withCredentials([file(credentialsId: 'ANSIBLE_VAULT', variable: 'VAULT_FILE')]) {
        sh """
            ansible-playbook \
                -i ansible/inventories/${environment}/hosts \
                -e deployment_version=${BUILD_VERSION} \
                -e deployment_strategy=${strategy} \
                --vault-password-file ${VAULT_FILE} \
                ansible/deploy.yml
        """
    }
}

// Smoke test function
def runSmokeTests(environment) {
    echo "Running smoke tests on ${environment}..."
    
    def endpoints = getEnvironmentEndpoints(environment)
    
    endpoints.each { endpoint ->
        sh """
            # Health check
            curl -f ${endpoint}/actuator/health || exit 1
            
            # Basic functionality test
            curl -f ${endpoint}/ || exit 1
            
            # API test
            curl -f ${endpoint}/public/rest/category || exit 1
        """
    }
}

// Get environment endpoints
def getEnvironmentEndpoints(environment) {
    // This would typically read from configuration
    def endpoints = [
        'staging': ['http://staging.journals.com'],
        'production': ['http://prod1.journals.com', 'http://prod2.journals.com']
    ]
    return endpoints[environment]
}