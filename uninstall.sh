#!/bin/sh

systemctl disable edge-heatcore-toolkit.service

docker rmi 713613010142.dkr.ecr.us-east-2.amazonaws.com/edge-heatcore-toolkit:latest

rm -f /etc/systemd/system/edge-heatcore-toolkit.service
rm -rf /etc/heatcore/eht
