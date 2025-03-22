
20 MAR 2025:

MVN LIFE CYCLE / PHASES / GOALS 
POM.XML --> PLUGINS & DEPENDENCIES 
PM TOOL -- GENRERATING PROJECT STRUCTURE 

ANT / GRADLE --> build tools 
mvn --- build + PM 

mvn archetype:generate 

======


MVN LIFE CYCLE -- PHASES -- PLUGINS -- GOAL
(go through this linked in post) 

https://www.linkedin.com/posts/madhukiran-gorekar_maven-buildlifecycle-devops-activity-7247579291457093633-GBIP?utm_source=share&utm_medium=member_desktop

=======================================

DAY-20--########################################################################


pipeline {
    agent none
    
    
    stages {
    
    
        stage('Clone Repository') {
            agent { label 'slave-1' } // Agent for Git operations
            steps {
               
                git branch: 'main', url: 'https://github.com/devopstraininghub/mindcircuit15d.git'
                
                
                stash includes: '', name: 'batch15mcCode'
            }
        }
        
        stage('Build with Maven') {
            agent { label 'slave-2' } // Agent for Maven build
            steps {
                script {
                    
                    unstash 'batch15mcCode'
                    
                   
                    sh 'mvn clean package'
                }
            }
        }
        
        
        
    }


    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}


DAY-21--########################################################################

21 MAR 25 :

=========================
GIT FORK -- WHY  

==================

ADDING ENVIRONEMNT VARIABLES :
Added an environment block to define reusable environment variables:
         GIT_URL – Git repository URL
         BRANCH – Git branch to clone
         TOMCAT_URL – Tomcat server URL
         TOMCAT_CREDENTIALS_ID – Credentials ID for Tomcat deployment
         CONTEXT_PATH – Context path for the app deployment
		 
This makes the pipeline cleaner, more flexible, and easier to maintain!
------------------------------

pipeline {
    agent any
	
    environment {
        GIT_URL = 'https://github.com/devopstraininghub/mindcircuit15d.git'
        BRANCH = 'main'
        TOMCAT_URL = 'http://54.91.227.106:8081/'
        TOMCAT_CREDENTIALS_ID = 'tomcat'
        CONTEXT_PATH = 'devops-app'
    }

    stages {

        stage('CLONE GITHUB CODE') {
            steps {
                echo 'In this stage, code will be cloned'
                git branch: "${BRANCH}", url: "${GIT_URL}"
            }
        }

        stage('BUILDING THE CODE') {
            steps {
                echo 'In this stage, code will be built and an mvn artifact will be generated'
                sh 'mvn clean install'
            }
        }

        stage('DEPLOY') {
            steps {
                echo 'In this stage, .war artifact will be deployed onto Tomcat'
                deploy adapters: [
                    tomcat9(
                        credentialsId: "${TOMCAT_CREDENTIALS_ID}", 
                        path: '', 
                        url: "${TOMCAT_URL}"
                    )
                ], 
                contextPath: "${CONTEXT_PATH}", 
                war: '**/*.war'
            }
        }
    }
}




========================================================================


JENKINS GIT WEBHOOK INTEGRATION  : 


WEBHOOKS :

http://54.159.26.167:8080/github-webhook/
================================================
pipeline {
    agent any
	
	triggers {
        githubPush() 
    }

    stages {
        stage('CLONE SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/devopstraininghub/mindcircuit15d.git'
            }
        }
		
		
		    stage('MVN BUILD') {
            steps {
                
				sh 'mvn clean install'
            }
        }
		
		
		    stage('DEPLOY TO TOMCAT') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://54.159.26.167:8090/')], contextPath: 'mcapp', war: '**/*.war'
            }
        }
    }
}


========================================================================


BUILD SHOUD CONTINUE EVEN IF A STAGE FAILS IN PIPELINE : (USING try & catch blocks) : 

pipeline {
    agent any

    stages {
	
	    stage('Clean Workspace') {
            steps {
                cleanWs() 
                 }
			
                }
	
        stage('CLONE GITHUB CODE') {
            steps {
			
			 script{ 
			
			    try {
                   echo 'In this stage code will be clone'
			     	git branch: 'main', url: 'https://github.com/devopstraininghub/mindcircuit15d.git'
				}
		
              catch (Exception e) {                        
                        echo "Stage 1 failed: ${e.message}" 

                  } 			
				
				}
        }
		}
		
        stage('BUILDING THE CODE') {
            steps {
			
			script { 
			try { 
                echo 'In this stage code will be build and mvn artifact will be generated'
				sh 'mvn clean install '
				} 
		  catch (Exception e) {                        
                        echo "Stage 2 failed: ${e.message}" 

                  } 					
            }
        }	
        } 		
		
        stage('DEPLOY') {
            steps {
                echo 'In this stage .war artiface will be deployed on to tomcat '
				deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://54.91.227.106:8081/')], contextPath: 'devops-app', war: '**/*.war'
				
            }
        }		
		
		
    }
}



================================================================================

PARALLEL stages execution: 

pipeline {
    agent any

    stages {
	
	    stage('Clean Workspace') {
             steps {
                cleanWs() 
                   } 
				   }
				   
		
        stage('CLONE GITHUB CODE') {
            steps {
			
			 script{ 
			
			    try {
                   echo 'In this stage code will be clone'
			     	git branch: 'main', url: 'https://github.com/devopstraininghub/mindcircuit15d.git'
				}
		
              catch (Exception e) {                        
                        echo "Stage 1 failed: ${e.message}" 

                  } 			
				
				}
        }
		}

        stage('deploy to multiple environments ') {
            parallel {			
			  stage('Lab') {
                    steps {
                        echo 'DEPLOYING ON lAB...'                        
                    }
					}
              stage('sbox') {
                    steps {
                        echo 'DEPLOYING ON sbox...'                        
                    }
                }
             stage('UAT') {
                    steps {
                        echo 'DEPLOYING ON uat...'                       
                    }
                }    

           stage('staging') {
                    steps {
                        echo 'Running Maven Install...'                       
                    }
                }   


            stage('PROD') {
                    steps {
                        echo 'Running Maven Install...'                       
                    }
                }   

				
                }
				}
        }
    }
  

