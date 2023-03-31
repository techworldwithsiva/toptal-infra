pipeline {
  agent any
  
  stages {
    stage('Clone') {
      script{
                echo "Clone started"
                gitInfo = checkout scm
                        
      }
    }

    stage('Terraform'){
            steps{
                script{
                    withAWS(credentials: 'aws-auth', region: "${REGION}") {
                        sh """
                         terraform init
                         terraform plan
                         terraform apply -auto-approve
                        """
                    }
                }
            }
        }
  
  post {
    
    
    success {
      echo 'Pipeline successful'
    }
    
    failure {
      echo 'Pipeline failed'
    }
  }
}
}