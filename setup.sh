#!/bin/bash

GROUP="it.si2001"
PROJECT="demo"

# ?
mvn archetype:generate \
    -DgroupId=$GROUP.$PROJECT \
    -DartifactId=$PROJECT \
    -DarchetypeGroupId=org.apache.maven.archetypes \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DarchetypeVersion=1.5 \
    -Dversion=0.0.1 \
    -DinteractiveMode=false


# ?
rm -vrf ./$PROJECT/src/test

mkdir -vp ./$PROJECT/src/main/java/it/si2001/$PROJECT/models
mkdir -vp ./$PROJECT/src/main/java/it/si2001/$PROJECT/services
mkdir -vp ./$PROJECT/src/main/java/it/si2001/$PROJECT/repositories
mkdir -vp ./$PROJECT/src/main/java/it/si2001/$PROJECT/controllers
mkdir -vp ./$PROJECT/src/main/java/it/si2001/$PROJECT/config

mkdir -vp ./$PROJECT/src/main/webapp/WEB-INF


# web.xml
touch ./$PROJECT/src/main/webapp/WEB-INF/web.xml
cat << EOT > ./$PROJECT/src/main/webapp/WEB-INF/web.xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee 
                             https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">
</web-app>
EOT
echo -e "\033[0;32m[INFO]\033[0m created web.xml"


# pom.xml
cat << EOT > ./$PROJECT/pom.xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  
  <groupId>$GROUP.$PROJECT</groupId>
  <artifactId>$PROJECT</artifactId>
  
  <name>$PROJECT</name>
  <version>0.0.1</version>
  <packaging>war</packaging>
  
  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.release>17</maven.compiler.release>
  </properties>
  
  <dependencies>
    
    <!-- Spring MVC -->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-webmvc</artifactId>
      <version>7.0.0-M9</version>
    </dependency>
    
    <!-- Spring Data JPA -->
    <dependency>
      <groupId>org.springframework.data</groupId>
      <artifactId>spring-data-jpa</artifactId>
      <version>4.0.0-M6</version>
    </dependency>
    
    <!-- Spring ORM -->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-orm</artifactId>
      <version>7.0.0-M9</version>
    </dependency>
    
    <!-- Hibernate -->
    <dependency>
      <groupId>org.hibernate.orm</groupId>
      <artifactId>hibernate-core</artifactId>
      <version>7.1.2.Final</version>
    </dependency>
    
    <!-- Thymeleaf -->
    <dependency>
      <groupId>org.thymeleaf</groupId>
      <artifactId>thymeleaf</artifactId>
      <version>3.1.3.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.thymeleaf</groupId>
      <artifactId>thymeleaf-spring5</artifactId>
      <version>3.1.3.RELEASE</version>
    </dependency>
    
  </dependencies>
  
  <build>
    <pluginManagement>
      <plugins>
        
        <!-- clean lifecycle -->
        <plugin>
          <artifactId>maven-clean-plugin</artifactId>
          <version>3.4.0</version>
        </plugin>
        
        <!-- default lifecycle, jar packaging -->
        <plugin>
          <artifactId>maven-resources-plugin</artifactId>
          <version>3.3.1</version>
        </plugin>
        <plugin>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.13.0</version>
        </plugin>
        <plugin>
          <artifactId>maven-surefire-plugin</artifactId>
          <version>3.3.0</version>
        </plugin>
        <plugin>
          <artifactId>maven-war-plugin</artifactId>
          <version>3.4.0</version>
        </plugin>
        
      </plugins>
    </pluginManagement>
  </build>
</project>
EOT
echo -e "\033[0;32m[INFO]\033[0m modified pom.xml"


# .gitignore
touch ./.gitignore
cat << EOT > ./.gitignore
target/
!.mvn/wrapper/maven-wrapper.jar
!**/src/main/**/target/
!**/src/test/**/target/

### IntelliJ IDEA ###
.idea/modules.xml
.idea/jarRepositories.xml
.idea/compiler.xml
.idea/libraries/
*.iws
*.iml
*.ipr

### Eclipse ###
.apt_generated
.classpath
.factorypath
.project
.settings
.springBeans
.sts4-cache
/.jdtls
/$PROJECT/.mvn
/$PROJECT/.settings
/$PROJECT/.classpath
/$PROJECT/.project

### NetBeans ###
/nbproject/private/
/nbbuild/
/dist/
/nbdist/
/.nb-gradle/
build/
!**/src/main/**/build/
!**/src/test/**/build/

### VS Code ###
.vscode/

### Mac OS ###
.DS_Store

### DB ###
/demo/demo
/.db
EOT
echo -e "\033[0;32m[INFO]\033[0m created .gitignore"


# docker-compose.yaml
touch ./$PROJECT/docker-compose.yaml
cat << EOT > ./$PROJECT/docker-compose.yaml
services:
  
  db:
    image: mysql:9.4.0
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: db
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin
      MYSQL_ROOT_PASSWORD: admin
    volumes:
      - ./.db:/var/lib/mysql
  
  adminer:
    image: adminer
    restart: unless-stopped
    ports:
      - "8060:8080"
  
  tomcat:
    image: tomcat:latest
    restart: unless-stopped
    ports:
      - "8050:8080"
    depends_on:
      - db
    volumes:
      - ./$PROJECT/target/$PROJECT-0.0.1.war:/usr/local/tomcat/webapps/ROOT.war
EOT
echo -e "\033[0;32m[INFO]\033[0m created docker-compose.yaml"


# build.sh
touch ./$PROJECT/build.sh
cat << EOT > ./$PROJECT/build.sh
#!/usr/bin/bash
mvn clean
mvn package
sudo docker-compose up -d
EOT
chmod +x ./$PROJECT/build.sh
echo -e "\033[0;32m[INFO]\033[0m created build.sh"


# run.sh
touch ./run.sh
cat << EOT > ./run.sh
#!/usr/bin/bash
cd ./$PROJECT || exit
./build.sh
EOT
chmod +x ./run.sh
echo -e "\033[0;32m[INFO]\033[0m created run.sh"


# stop.sh
touch ./stop.sh
cat << EOT > ./stop.sh
#!/bin/bash
cd ./$PROJECT || exit
sudo docker-compose stop
sudo docker-compose down
EOT
chmod +x ./stop.sh
echo -e "\033[0;32m[INFO]\033[0m created stop.sh"
