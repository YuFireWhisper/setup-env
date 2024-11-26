#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
    echo "請使用 sudo 運行此腳本"
    exit 1
fi

REAL_USER=${SUDO_USER:-$USER}
HOME_DIR="/home/$REAL_USER"

echo "開始配置開發環境..."

echo "更新系統套件..."
apt-get update
apt-get upgrade -y

echo "安裝基本工具..."
apt-get install -y \
    git \
    curl \
    wget \
    tree \
    build-essential \
    python3 \
    python3-pip \
    clangd \
    neovim \
    unzip \
    tar \
    gzip \

echo "創建 Python 符號連結..."
if [ ! -e /usr/bin/python ]; then
    ln -s /usr/bin/python3 /usr/bin/python
fi

if [ ! -e /usr/bin/pip ]; then
    ln -s /usr/bin/pip3 /usr/bin/pip
fi

echo "安裝 NodeJS..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install -y nodejs

echo "配置 SSH 權限..."
SSH_DIR="$HOME_DIR/.ssh"
if [ -d "$SSH_DIR" ]; then
    chmod 700 "$SSH_DIR"
    [ -f "$SSH_DIR/id_rsa" ] && chmod 600 "$SSH_DIR/id_rsa"
    [ -f "$SSH_DIR/id_rsa.pub" ] && chmod 644 "$SSH_DIR/id_rsa.pub"
    chown -R $REAL_USER:$REAL_USER "$SSH_DIR"
    
    if [ ! -f "$SSH_DIR/config" ]; then
        echo "創建 SSH 配置..."
        cat > "$SSH_DIR/config" << EOF
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa
    IdentitiesOnly yes
EOF
        chmod 644 "$SSH_DIR/config"
        chown $REAL_USER:$REAL_USER "$SSH_DIR/config"
    fi
fi

echo "配置 Git..."
sudo -u $REAL_USER git config --global user.email "yu.whisper.personal@gmail.com"
sudo -u $REAL_USER git config --global user.name "YuFireWhipser"
sudo -u $REAL_USER git config --global core.editor "vim"

echo "配置 Neovim..."
CONFIG_DIR="$HOME_DIR/.config"
if [ ! -d "$CONFIG_DIR" ]; then
    mkdir -p "$CONFIG_DIR"
    chown $REAL_USER:$REAL_USER "$CONFIG_DIR"
fi

if [ ! -d "$CONFIG_DIR/nvim" ]; then
    echo "克隆 Neovim 配置..."
    sudo -u $REAL_USER git clone git@github.com:yufirewhisper/nvim.git "$CONFIG_DIR/nvim"
fi

echo "安裝xsel(允許系統剪貼簿)"
sudo apt install xclip

echo "驗證安裝..."
echo "Python 版本:"
python --version
echo "Pip 版本:"
pip --version
echo "Node.js 版本:"
node --version
echo "npm 版本:"
npm --version

echo "環境配置完成！"
