#!/bin/bash

# 安装完服务器之后更新一下包。
sudo apt-get update -y && apt-get upgrade -y

# 清理 docker 历史包以及安装下面需要用到的工具包
sudo apt-get remove --autoremove --purge docker docker-engine docker.io containerd runc -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release vim git net-tools htop neofetch cpulimit -y
sudo apt-get clean

# 安装 docker 并且配置开机自启
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker && systemctl enable docker

# 安装 docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# docker-compose 启动 qbittorrent
sudo mkdir /opt/qbittorrent
sudo cat > /opt/qbittorrent/docker-compose.yaml <<EOF
version: "3.9"
services:
  qbittorrent:
    image: linuxserver/qbittorrent
    container_name: qbittorrent
    environment:
      - PUID=0
      - PGID=0
      - TZ=Asia/Shanghai
    volumes:
      - /opt/qbittorrent/config:/config
      - /opt/qbittorrent/downloads:/downloads
    ports:
      - 6881:6881
      - 6881:6881/udp
      - 8080:8080
    restart: unless-stopped
EOF
cd /opt/qbittorrent && sudo docker-compose up -d