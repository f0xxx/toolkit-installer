#!/bin/sh

systemctl stop edge-heatcore-toolkit.service
systemctl disable edge-heatcore-toolkit.service

docker rmi 713613010142.dkr.ecr.ap-southeast-1.amazonaws.com/edge-heatcore-toolkit:latest

rm -f /etc/systemd/system/edge-heatcore-toolkit.service
rm -rf /etc/heatcore/eht
