#!/bin/sh

export PATH=$PATH:/snap/bin

mkdir -p /etc/heatcore/ehn/logs
mkdir -p /etc/heatcore/ehn/profile
curl -o /etc/systemd/system/edge-heatcore-nuc.service https://gitee.com/hunt-sky/toolkit-installer/raw/release/edge-heatcore-nuc.service

docker pull 713613010142.dkr.ecr.ap-southeast-1.amazonaws.com/heatcore-nuc:latest
if [ $? -ne 0 ]; then
    echo "docker pull nuc failed!"
    exit 1
fi

systemctl disable edge-heatcore-nuc.service
systemctl enable edge-heatcore-nuc.service
systemctl start edge-heatcore-nuc.service
systemctl status edge-heatcore-nuc.service
