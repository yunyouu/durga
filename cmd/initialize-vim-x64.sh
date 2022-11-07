#!/bin/bash
# 之后配置增加，添加更多的插件

# 安装 vim 并且使用预制好的配置文件
apt install vim -y
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl -o ~/.vimrc https://raw.githubusercontent.com/yunyouu/durga/main/config/.vimrc
vim +PluginInstall +qall