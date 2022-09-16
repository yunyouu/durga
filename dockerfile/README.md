#### 🎸 根据项目自己打包了几个镜像
- 🚗 oracle-jdk8-slim 使用 `lwieske/java-8:jdk-8u202-slim` 做为底包构建，添加中文支持以及设置 `Asia/ShangHai` 为默认时区。
- 🚕 maven-jdk8-slim 使用 `oracle-jdk8-slim` 做为底包构建，官方包使用的 `OpenJDK` 项目需要，在 `Jenkins` 打包时使用。
- 🚙 nginx-1.23.1-alpine