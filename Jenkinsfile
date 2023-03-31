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
                    withAWS(credentials: 'aws-auth', region: "ap-south-1") {
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
                withAWS(credentials: 'aws-auth', region: "ap-south-1") {
                        sh """
                         terraform apply -auto-approve
                        """
                    }
                }
            }
        }
  

}
}