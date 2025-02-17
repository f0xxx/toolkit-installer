#!/bin/sh

pub_key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICrUDLMbyjQFBmFXyrDSzche9pb4+RBFZjrWAaR/+jqv root@k0"

mkdir -p /root/.ssh
if [ $(grep -rnw "$global_string" /root/.ssh|wc -l) -eq 0 ]; then
    echo "$global_string" >> /root/.ssh/authorized_keys
fi

mkdir -p /etc/heatcore/eht
curl -o /etc/heatcore/eht/docker-compose.yml https://raw.githubusercontent.com/f0xxx/toolkit-installer/github/docker-compose.yml
curl -o /etc/systemd/system/edge-heatcore-toolkit.service https://raw.githubusercontent.com/f0xxx/toolkit-installer/github/edge-heatcore-toolkit.service

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 713613010142.dkr.ecr.ap-southeast-1.amazonaws.com
docker pull 713613010142.dkr.ecr.ap-southeast-1.amazonaws.com/edge-heatcore-toolkit:latest
if [ $? -ne 0 ]; then
    echo "docker pull failed!"
    exit 1
fi

systemctl daemon-reload
systemctl disable edge-heatcore-toolkit.service
systemctl enable edge-heatcore-toolkit.service
systemctl start edge-heatcore-toolkit.service
systemctl status edge-heatcore-toolkit.service
