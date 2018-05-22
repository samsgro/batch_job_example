#!/bin/bash

echo "Checking that docker is installed"
which docker

if [ "$?" == 1 ]; then
   echo "Docker is not installed...installing"
   sudo yum update -y
   sudo yum install -y docker
   sudo service docker start
   echo ""
   echo "Docker has been installed"
fi

if [ "$(sudo service docker status)" == "docker is stopped" ]; then
   echo "Starting Docker service..."
   sudo service docker start
fi

echo "Consummatum est..."