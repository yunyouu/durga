#!/bin/bash

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
