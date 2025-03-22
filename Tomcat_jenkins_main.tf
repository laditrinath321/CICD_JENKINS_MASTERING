# Define the AWS provider configuration.
provider "aws" {
  region = "us-east-1"  

}


resource "aws_instance" "jenkins-server" {
  ami = "ami-05b10e08d247fb927"
  instance_type = "t2.micro"
  key_name = "test"
  vpc_security_group_ids = ["sg-0c09136a4ce30004e"]

 

  

  provisioner "local-exec" {
    command = "echo 'hello batch15 champs' > batch15.txt"
  }
   
   connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/91888/OneDrive/Documents/DEVOPS_COURSE/Linux_Practice/test.pem")
    host        = self.public_ip 
          }


   provisioner "remote-exec" {
   inline = [
      "sudo yum update –y" ,
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",

     "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",

     "sudo yum upgrade",
     "sudo dnf install java-17-amazon-corretto -y",
     "sudo yum install jenkins -y",
     "sudo systemctl enable jenkins",
     "sudo systemctl start jenkins",
     "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
     "sudo yum install maven git -y"
    ] 

  }
  tags = {
    Name = "JENKINS-SERVER"
  }

   }


   resource "aws_instance" "Tomcat-server" {
    ami = "ami-05b10e08d247fb927"
    instance_type = "t2.micro"
    key_name = "test"
    vpc_security_group_ids = ["sg-0c09136a4ce30004e"]

    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/91888/OneDrive/Documents/DEVOPS_COURSE/Linux_Practice/test.pem")
    host        = self.public_ip 
          }


   provisioner "remote-exec" {

    inline = [
      "sudo yum install java -y",
      "cd /opt",
      "sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.102/bin/apache-tomcat-9.0.102.tar.gz",
      "sudo tar -xvf /opt/apache-tomcat-9.0.102.tar.gz",
      "cd /opt/apache-tomcat-9.0.102/webapps/manager/META-INF",
      "sudo sed -i 's/\\\"127\\\\.\\\\d+\\\\.\\\\d+\\\\.\\\\d+|::1|0:0:0:0:0:0:0:1\\\"/\\\".*\\\"/g' context.xml",
      "cd /opt/apache-tomcat-9.0.102/conf",
      "sudo mv tomcat-users.xml tomcat-users_bkup_$(date +%d%b%Y).xml",
      "echo '<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<tomcat-users>\n  <role rolename=\"manager-gui\"/>\n  <user username=\"tomcat\" password=\"tomcat\" roles=\"manager-gui,manager-script,manager-status\"/>\n</tomcat-users>' | sudo tee tomcat-users.xml",
      "sudo /opt/apache-tomcat-9.0.102/bin/startup.sh"
   ]

 

  }



    tags = {
      Name = "Tomcat-server"
    }
     
   }

  #  resource "aws_instance" "slave-1" {
  #  ami = "ami-05b10e08d247fb927"
  #  instance_type = "t2.micro"
  #  key_name = "test"
  #  vpc_security_group_ids = ["sg-0c09136a4ce30004e"]
  #  tags = {
  #    Name = "slave-1"
  #  }
     
  #  }   


   output "jenkins-server-public_ip" {
     value = aws_instance.jenkins-server.public_ip
   }

  output "Tomcat-server-public_ip" {
    value = aws_instance.Tomcat-server.public_ip
    
  }

 # output "slave-1-public_ip" {
 #  value = aws_instance.slave-1.public_ip
    
 # }