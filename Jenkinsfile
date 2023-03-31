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
                script{
                sh ""
                    terraform apply -auto-approve
                ""
                }
            }
        }
  

}
}