#!/bin/sh

systemctl stop edge-heatcore-nuc.service
systemctl disable edge-heatcore-nuc.service

docker rmi 713613010142.dkr.ecr.ap-southeast-1.amazonaws.com/heatcore-nuc:latest

rm -f /etc/systemd/system/edge-heatcore-nuc.service
rm -rf /etc/heatcore/ehn
