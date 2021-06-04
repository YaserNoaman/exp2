pipeline {
    agent any
    stages {
    stage('code_ceckout'){
            steps{
                script{
				    
                    sh 'git clone https://github.com/YaserNoaman/exp2.git'
                    
                }
            }
	    } 	
        		
        stage('code compile'){
            steps{
                script{
				      
				      def POM_DIR = "exp2/CLASSCODE/FILE"
                     sh "/tomcat_install/MAVEN/apache-maven-3.6.3/bin/mvn compile -f ${POM_DIR}/pom.xml"
					 
                }
            }
        }
		stage('CODE_PACKAGE'){
		     steps{
			    script{
                        def POM_DIR = "exp2/CLASSCODE/FILE"
						sh "/tomcat_install/MAVEN/apache-maven-3.6.3/bin/mvn package -f ${POM_DIR}/pom.xml"
                    }						
		         }
             }	

        stage('ARTIFACT_UPLOAD'){
		      steps{
			     script{
				          def POM_DIR = "exp2/CLASSCODE/FILE"
				          def mavenPom = readMavenPom file: "${POM_DIR}/pom.xml"
				          nexusArtifactUploader artifacts: [[artifactId: 'addressbook', classifier: '', file: 'exp2/CLASSCODE/FILE/target/addressbook.war', type: 'war']], credentialsId: 'nexus-repo-conn', groupId: 'com.edurekademo.tutorial', nexusUrl: '192.168.0.100:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'edureka-app', version: "${mavenPom.version}"

                        }
					}
                }

        stage('ARTIFACT_DOWNLOAD'){ 
              steps{
        	     script{
				          def POM_DIR = "exp2/CLASSCODE/FILE"
				          def mavenPom = readMavenPom file: "${POM_DIR}/pom.xml"
        		          sh "wget --user=admin --password=Oracle#123 http://192.168.0.100:8081/repository/edureka-app/com/edurekademo/tutorial/addressbook/${mavenPom.version}/addressbook-${mavenPom.version}.war"
						  sh "cp -pr addressbook-2.0.war addressbook.war"
						  sh "mv addressbook.war /tomcat_install/apache-tomcat-9.0.35/webapps/"
        
                        }
        			}
                }					
				
	 
	}	
    post {
        success {
		  
            mail to: 'yasernoaman9032@gmail.com',
			     subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
				 body: "${env.BUILD_URL} has result ${currentBuild.result}"
				 
        }
        failure {
            
			emailext attachLog: true,
                       body: "PLEASE FIND THE RESULT OF CURRENT BUILD : ${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                       recipientProviders: [ requestor()],
                       subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"

        }
    }
}

