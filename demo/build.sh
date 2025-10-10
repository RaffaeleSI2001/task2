#!/usr/bin/bash
mvn clean
mvn package
sudo docker-compose up -d
