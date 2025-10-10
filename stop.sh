#!/bin/bash
cd ./demo || exit
sudo docker-compose stop
sudo docker-compose down
sudo rm -vrf ./demo/demo ./demo/target
