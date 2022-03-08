#!/bin/bash

# docker-compose 启动 qbittorrent，并且使用 host 网络模式。当前镜像不支持仅 IPv6
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
    network_mode: "host"
    restart: unless-stopped
EOF
cd /opt/qbittorrent && sudo docker-compose up -d
