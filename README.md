# durga

👻 常用配置文件备份、加速下载以及使用文档

## 环境初始化脚本

### Ubuntu 系统个人配置初始化
1. 更新系统包
2. 安装常用应用
3. 配置 zsh
```
sh -c "$(wget -O- https://raw.githubusercontent.com/yunyouu/durga/main/environment_scripts/server-initial-base-ubuntu.sh)"
```

### Ubuntu 安装 docker 环境
1. 安装 docker-ce
2. 安装 docker-compose
```
sh -c "$(wget -O- https://raw.githubusercontent.com/yunyouu/durga/main/environment_scripts/server-initial-docker-ubuntu.sh)"
```

## 应用配置脚本

### docker-compose 安装 qbittorrent
- webui 端口 8080
- 上传端口固定 32671 ，需要启动后在面板调整到对应
```
curl -L https://raw.githubusercontent.com/yunyouu/durga/main/application_scripts/do-qbittorrent-docker-compose.sh | bash
```