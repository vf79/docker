#!/bin/bash
sudo echo "" > $(docker inspect --format='{{.LogPath}}' $1)
sudo docker logs $1
