#!/bin/bash
sudo apt-get install xbindkeys i3-wm htop chromium gvim ipython ttf-anonymous-pro
cd ~/
git clone https://github.com/aaevan/aaevan_rc_files
cd aaevan_rc_files
mv .* ..
wget https://github.com/tpope/vim-vividchalk/archive/master.zip
unzip master.zip
mkdir -m ~/.vim/colors
mv vim-vividchalk-master/colors/* ~/.vim/colors/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
gvim +PluginInstall +qall
#add autocomplete for npm
