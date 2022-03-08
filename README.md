# durga

👻 常用配置文件备份、加速下载以及使用文档

## 环境初始化脚本

### Ubuntu 及 Debian 系统个人配置初始化
1. 更新系统包
2. 安装常用应用
3. 配置 zsh
```
sh -c "$(wget -O- https://raw.githubusercontent.com/yunyouu/durga/main/environment_scripts/server-initial-base.sh)"
```

### Ubuntu 及 Debian 安装 docker 环境
1. 安装 docker-ce
2. 安装 docker-compose
```
sh -c "$(wget -O- https://raw.githubusercontent.com/yunyouu/durga/main/environment_scripts/server-initial-docker.sh)"
```

## 应用配置脚本

### docker-compose 安装 qbittorrent
- 网络采用 host 模式。
- webui 端口 8080。
- 上传端口固定 6881 ，大部分网站已经禁用，需要手动调整。
```
curl -L https://raw.githubusercontent.com/yunyouu/durga/main/application_scripts/do-qbittorrent-docker-compose.sh | bash
```