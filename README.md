# durga

👻 常用配置文件备份、加速下载以及使用文档

## 服务器初始化

```
sh -c "$(wget -O- https://raw.githubusercontent.com/yunyouu/durga/main/server-initial-ubuntu20.04/server-initial-ubuntu20.04.sh)"
```

## 应用配置更新

以下有些配置会包含在应用初始化当中，也有其他一些应用列表。

### `vim` 配置

1. 直接访问 github raw

```
wget -O ~/.vimrc https://raw.githubusercontent.com/yunyouu/durga/main/configuration/vim/.vimrc
```

2. 国内加速脚本地址

```
wget -O ~/.vimrc https://raw.fastgit.org/yunyouu/durga/main/configuration/vim/.vimrc
```

## 使用 docker-compose 安装 qbittorrent

1. 直接访问 github raw

```
curl -L https://raw.githubusercontent.com/yunyouu/durga/main/scripts/do-qbittorrent-docker-compose/do-qbittorrent-docker-compose.sh | bash
```

2. 国内加速脚本地址

```
curl -L https://raw.fastgit.org/yunyouu/durga/main/scripts/do-qbittorrent-docker-compose/do-qbittorrent-docker-compose.sh | bash
```
