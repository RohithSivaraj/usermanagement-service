pipeline {
  agent any
  tools {
    maven 'Maven'  // This should match the name you gave in Global Tool Config
}

  environment {
    AWS_ACCOUNT_ID = '529088274428'
    AWS_REGION = 'us-east-1'
    ECR_REPO = 'rohsiv-repo-new'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Maven Package') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          def gitCommit = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
          def imageName = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${gitCommit}"

          sh "docker build -t ${imageName} ."
          sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
          sh "docker push ${imageName}"

          // Save image name for deployment stage
          env.IMAGE_NAME = imageName
        }
      }
    }

    stage('Deploy to ECS') {
      steps {
        script {
          // Use AWS CLI or SDK to update ECS service with new image
          sh """
          aws ecs update-service --cluster your-ecs-cluster-name --service your-ecs-service-name \
          --force-new-deployment --region ${AWS_REGION}
          """
        }
      }
    }
  }
}