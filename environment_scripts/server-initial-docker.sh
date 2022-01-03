#!/bin/bash

# 清理 docker 历史包以及安装下面需要用到的工具包
apt-get remove --autoremove --purge docker docker-engine docker.io containerd runc -y

# 安装 docker 并且配置开机自启
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y && sudo apt-get upgrade -y
apt-get install docker-ce docker-ce-cli containerd.io -y
systemctl start docker && systemctl enable docker

# 安装 docker-compose
curl -L "https://hub.nzk.im/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose