#!/bin/bash
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)
if [ "$1" == "--rmi" ]; then
  sudo docker rmi $(sudo docker images -a -q)
fi
sudo docker volume rm $(sudo docker volume ls -q)
sudo docker volume prune
sudo docker network prune
sudo docker system prune

sudo docker volume ls
sudo docker network ls
sudo docker image ls -a
sudo docker ps -a
