pipeline {
  agent any
  
  stages {
    stage('Clone') {
        steps{
        script{
                    echo "Clone started"
                    gitInfo = checkout scm
                            
        }
      }
    }

    stage('Terraform Plan'){
            steps{
                script{
                    withAWS(credentials: 'aws-auth', region: "${REGION}") {
                        sh """
                         terraform init
                         terraform plan
                        """
                    }
                }
            }
        }
    stage('Terraform Apply') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
            }
            steps {
                sh ""
                    terraform apply -auto-approve
                ""
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