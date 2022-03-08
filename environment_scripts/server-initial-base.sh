#!/bin/bash

apt-get install apt-transport-https ca-certificates gnupg lsb-release sudo -y

# 刷新一下数据源同时更新一下本地包
sudo apt-get update -y && sudo apt-get upgrade -y
# 安装系统使用基础包

# 安装常用的扩展应用
sudo apt-get install curl unzip git net-tools htop neofetch lrzsz -y

# 安装 vim 并且使用预制好的配置文件
sudo apt-get install vim -y
sudo curl -o ~/.vimrc https://raw.nzk.im/yunyouu/durga/main/configuration/vim/.vimrc

# 安装 zsh 以及配置 ohmyzsh
sudo apt-get install zsh -y
# 无人值守安装 ohmyzsh
sh -c "$(curl -fsSL https://raw.nzk.im/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# 使用自己配置的配置文件，配置项较多之后再采取 vim 配置文件的做法
sudo cat > ~/.zshrc <<EOF
export ZSH="/root/.oh-my-zsh"
export LC_CTYPE=en_US.UTF-8

ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"

plugins=(extract)

source ~/.oh-my-zsh/oh-my-zsh.sh
EOF

sudo cat > /etc/ssh/sshd_config <<EOF
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
Subsystem	sftp	/usr/lib/openssh/sftp-server
EOF

# 设置服务器时区为上海
sudo timedatectl set-timezone 'Asia/Shanghai'

# 最后清理一下包
sudo apt-get clean -y && apt-get autoremove -y

# 添加 BBR 模块
sudo echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
sudo echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf

sudo sysctl -p

# 写入个人用的公玥
sudo mkdir ~/.ssh && sudo chmod 700 ~/.ssh
sudo touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZuMeivqcvRV+KkjD+RLPztGUGecAqouWbo2JYUHdS8oIZi65pHk3KlCTeqr/0LxKx4+8kNxUx12O5C08jij8IktrWdVsQ36j+wcfLH2eEco0JyJ6ijcmD5g8911yP5m8gMGpg8++SL41m9xtMG/bNxfvceMhdd6U1tSiFsFNklL0F0AN9Olvg5Or6lw5juRMhEV7L2AxxeCjvkNn+g5M5MaY2shCaTUw8cue9fo/bY2PS9WF6bf5/CRMrU83qSS7/CE6BP/IUWjw5/uPFP7GogMXPMt8D9W8yhleSkgXWJelZT7CQ58v9hCx9lOXwdg4rPhCKFn94GVsFk4KTuTtP root@self-host" >> ~/.ssh/authorized_keys

# 删除 root 账号密码并且只允许密钥登录
sudo passwd -d root

# 最后的最后，设置 zsh 为默认 shell，并且切换到 zsh
sudo chsh -s $(which zsh) && zsh

systemctl restart sshd