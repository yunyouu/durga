#!/bin/bash

# 安装完服务器之后更新一下包。
sudo apt-get update -y && apt-get upgrade -y

sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release vim git net-tools htop neofetch cpulimit -y
sudo apt-get clean

curl -o ~/.vimrc https://raw.githubusercontent.com/yunyouu/durga/main/configuration/vim/.vimrc

read -p "是否需要安装 Docker 相关环境？（y/n 默认 n）" IS_Docker_ENV

if [ $IS_Docker_ENV = "y" ]; then
    
    # 清理 docker 历史包以及安装下面需要用到的工具包
    sudo apt-get remove --autoremove --purge docker docker-engine docker.io containerd runc -y

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
fi