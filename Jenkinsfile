@Library("Shared") _
pipeline {
    agent {label "god"}
    stages {
        stage("Hello"){
           steps{
               script{
                   hello()
               }
           }
        }
        stage("code"){
            steps{
                script{
                   clone("https://github.com/bhavs09/django-notes-app.git", "main" )
                }
            }
        }
        stage("build"){
            steps{
                script{
                    docker_build("notes-app","latest","bhavs1999")
                }
            }   
        }
        stage("Push to DockerHub"){
            steps{
                script{
               docker_push("notes-app", "latest", "bhavs1999")
                
                }
            }
        }
        stage("deploy"){
            steps{
                echo "deploying the code"
                sh "docker compose up -d"
            }
        }
    }
}
