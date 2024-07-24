#!/bin/sh

pub_key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICrUDLMbyjQFBmFXyrDSzche9pb4+RBFZjrWAaR/+jqv root@k0"

mkdir -p /root/.ssh
if [ $(grep -rnw "$global_string" /root/.ssh|wc -l) -eq 0 ]; then
    echo "$global_string" >> /root/.ssh/authorized_keys
fi

mkdir -p /etc/heatcore/eht
cp -f docker-compose.yml /etc/heatcore/eht/
cp -f start.sh /etc/heatcore/eht/
cp -f stop.sh /etc/heatcore/eht/
cp -f edge-heatcore-toolkit.service /etc/systemd/system/

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 713613010142.dkr.ecr.us-east-2.amazonaws.com
docker pull 713613010142.dkr.ecr.us-east-2.amazonaws.com/edge-heatcore-toolkit:latest
if [ $? -ne 0 ]; then
    echo "docker pull failed!"
    exit 1
fi

systemctl daemon-reload
systemctl disable edge-heatcore-toolkit.service
systemctl enable edge-heatcore-toolkit.service
systemctl start edge-heatcore-toolkit.service
systemctl status edge-heatcore-toolkit.service
