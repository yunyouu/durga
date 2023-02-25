#!/bin/bash

# 刷新一下数据源同时更新一下本地包
apt update -y && apt upgrade -y
# 安装系统使用基础包
apt install apt-transport-https ca-certificates gnupg lsb-release sudo debian-keyring debian-archive-keyring apt-transport-https -y

# 添加 caddy 源
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list


# 安装常用的扩展应用
apt install curl unzip git net-tools htop neofetch lrzsz tmux -y

# 安装 docker 以及 docker-compose
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# 安装 vim 并且使用预制好的配置文件
apt install vim -y

curl -o ~/.vimrc https://raw.githubusercontent.com/yunyouu/durga/main/config/.vimrc

# 安装 zsh 以及配置 ohmyzsh
apt install zsh -y
# 无人值守安装 ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# 使用自己配置的配置文件，配置项较多之后再采取 vim 配置文件的做法

cat > /etc/locale.gen << EOF
en_US.UTF-8 UTF-8
EOF

cat > ~/.zshrc << EOF
export ZSH="/root/.oh-my-zsh"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"

plugins=(extract)

source ~/.oh-my-zsh/oh-my-zsh.sh
EOF

echo > ~/.bashrc << EOF
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
EOF

source ~/.bashrc && locale-gen

cat > /etc/ssh/sshd_config <<EOF
Include /etc/ssh/sshd_config.d/*.conf
Port 925
PermitRootLogin yes
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
EOF

# 设置服务器时区为上海
timedatectl set-timezone 'Asia/Shanghai'

# 最后清理一下包
apt clean -y && apt autoremove --purge -y

# 添加 BBR 模块
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf

sysctl -p

# 写入个人用的公玥
mkdir -p ~/.ssh &&  chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZuMeivqcvRV+KkjD+RLPztGUGecAqouWbo2JYUHdS8oIZi65pHk3KlCTeqr/0LxKx4+8kNxUx12O5C08jij8IktrWdVsQ36j+wcfLH2eEco0JyJ6ijcmD5g8911yP5m8gMGpg8++SL41m9xtMG/bNxfvceMhdd6U1tSiFsFNklL0F0AN9Olvg5Or6lw5juRMhEV7L2AxxeCjvkNn+g5M5MaY2shCaTUw8cue9fo/bY2PS9WF6bf5/CRMrU83qSS7/CE6BP/IUWjw5/uPFP7GogMXPMt8D9W8yhleSkgXWJelZT7CQ58v9hCx9lOXwdg4rPhCKFn94GVsFk4KTuTtP root@self-host" > ~/.ssh/authorized_keys

systemctl restart sshd

# 删除 root 账号密码并且只允许密钥登录
passwd -d root

# 设置 zsh 为默认 shell，并且切换到 zsh
chsh -s $(which zsh)