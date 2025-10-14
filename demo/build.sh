#!/usr/bin/bash

# Clean and prepare war archive
mvn clean
mvn package

# Check that war archive exists and is not empty
WAR_PATH="./target/demo-0.0.1.war"
while [ ! -s "$WAR_PATH" ]; do
  echo "Waiting for WAR file to be ready..."
  # ls -lh "$WAR_PATH"
  sleep 1
done

# Run containers
echo "WAR file is ready. Starting Docker..."
sudo docker-compose build
sudo docker-compose up -d
