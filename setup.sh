#!/bin/sh

git clone https://github.com/MarcWeber/vim-addon-manager.git
mkdir ~/.vim-addons
mv vim-addon-manager ~/.vim-addons/
cat README >> ~/.vimrc
