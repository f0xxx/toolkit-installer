#!/bin/sh

export PATH=$PATH:/snap/bin

pub_key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICrUDLMbyjQFBmFXyrDSzche9pb4+RBFZjrWAaR/+jqv root@k0"

mkdir -p /root/.ssh
if [ $(grep -rnw "$pub_key" /root/.ssh|wc -l) -eq 0 ]; then
    echo "$pub_key" >> /root/.ssh/authorized_keys
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
fi

mkdir -p /etc/heatcore/eht
curl -o /etc/systemd/system/edge-heatcore-toolkit.service https://gitee.com/hunt-sky/toolkit-installer/raw/release/edge-heatcore-toolkit.service

docker pull 713613010142.dkr.ecr.ap-southeast-1.amazonaws.com/edge-heatcore-toolkit:latest
if [ $? -ne 0 ]; then
    echo "docker pull toolkit failed!"
    exit 1
fi

systemctl daemon-reload
systemctl disable edge-heatcore-toolkit.service
systemctl enable edge-heatcore-toolkit.service
systemctl start edge-heatcore-toolkit.service
systemctl status edge-heatcore-toolkit.service
