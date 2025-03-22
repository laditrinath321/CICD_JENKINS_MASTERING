cd /opt
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.102/bin/apache-tomcat-9.0.102.tar.gz
sudo tar -xvf /opt/apache-tomcat-9.0.102.tar.gz
cd /opt/apache-tomcat-9.0.102/webapps/manager/META-INF
sudo sed -i 's/"127\\.\\d+\\.\\d+\\.\\d+|::1|0:0:0:0:0:0:0:1"/".*"/g' context.xml
cd /opt/apache-tomcat-9.0.102/conf
sudo mv tomcat-users.xml tomcat-users_bkup_18mar2025.xml
sudo echo '<?xml version="1.0" encoding="utf-8"?>
        <tomcat-users>
        <role rolename="manager-gui"/>
        <user username="tomcat" password="tomcat" roles="manager-gui, manager-script, manager-status"/>
        </tomcat-users>' > tomcat-users.xml
cd /opt/apache-tomcat-9.0.102/conf/
sudo sed -i 's/Connector port="8080"/Connector port="8090"/g' server.xml
sudo /opt/apache-tomcat-9.0.102/bin/startup.sh
