#### DURGA 个人脚本仓库

👻 常用系统初始化、软件编排、系统备份脚本

1. debian、ubuntu 系统初始化
```
wget -O- https://raw.githubusercontent.com/yunyouu/durga/main/scripts/initial_debian.sh | bash
```

2. docker-compose 安装 Loki 日志手机系统
- loki 日志存储
- promtail 通过 docker.sock 收集汇总容器内部日志
- grafana 日志查询
```
git clone https://github.com/yunyouu/durga && mv ./services/loki /opt/

cd /opt/loki && docker-compose up -d
```