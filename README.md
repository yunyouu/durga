本仓库主要会包含以下内容：
- 📦 自己打包的 `docker` 镜像 `dockerfile` 文件
- 📒 `Linux` 常用的基础工具配置文件信息
- 🐎 `Linux` 常使用的通用脚本，服务器可以直接使用
- 🚌 实际使用过后整理下来的编排脚本 + 配置文件（`docker-compose`）
---
#### 🍉 `Debian11`、`Ubuntu20.04` 系统初始化环境，包含以下内容：
1. 系统更新（`apt update && apt upgrade`），基础环境安装
2. `zsh`、`oh-mys-zsh` 安装，设置默认 `shell` 为 zsh
3. 安装 `docker`、`docker-compose`
4. `ssh` 使用 `back_sea` 密钥登录，端口设置为 925（所以这个脚本基本就是给我自己用的）

- Debian x86 初始化环境
```
wget -O- https://raw.githubusercontent.com/yunyouu/durga/main/cmd/debian-self-initital-x86.sh | bash
```

- Ubuntu x86 初始化环境
```
wget -O- https://raw.githubusercontent.com/yunyouu/durga/main/cmd/ubuntu-self-initital-x86.sh | bash
```

#### 📓 常用的 `VIM` 配置整理到一起，直接本地覆盖使用
- github raw 下载
```
wget -O ~/.vimrc https://raw.githubusercontent.com/yunyouu/durga/main/config/.vimrc
```