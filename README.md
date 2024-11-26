# Development Environment Setup

個人開發環境配置腳本，用於快速配置新環境。

## 支援的系統
- Ubuntu

## 使用方法

### 前置配置：SSH 設定
1. 檢查是否已有 SSH 金鑰：
   ```bash
   ls -la ~/.ssh
   ```

2. 如果沒有，生成新的 ED25519 金鑰：
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

3. 設置正確的權限：
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/id_ed25519
   chmod 644 ~/.ssh/id_ed25519.pub
   ```

4. 創建或編輯 SSH 配置文件：
   ```bash
   vim ~/.ssh/config
   ```
   添加以下內容：
   ```
   Host github.com
       HostName github.com
       User git
       IdentityFile ~/.ssh/id_ed25519
       IdentitiesOnly yes
   ```
   設置配置文件權限：
   ```bash
   chmod 644 ~/.ssh/config
   ```

5. 將公鑰添加到 GitHub：
   ```bash
   # 複製公鑰內容
   cat ~/.ssh/id_ed25519.pub
   ```
   然後在 GitHub 設置中添加 SSH key

6. 測試 SSH 連接：
   ```bash
   ssh -T git@github.com
   ```

### Ubuntu 環境配置
1. 安裝 git：
   ```bash
   sudo apt update
   sudo apt install git
   ```

2. 克隆倉庫：
   ```bash
   git clone git@github.com:YuFireWhisper/setup-env.git -b ubuntu
   ```

3. 進入目錄：
   ```bash
   cd setup-env
   ```

4. 給腳本執行權限：
   ```bash
   chmod +x setup.sh
   ```

5. 運行腳本：
   ```bash
   sudo ./setup.sh
   ```

## 包含的配置
- 基本開發工具（git, curl, wget, tree）
- Python 環境
- Node.js
- C/C++ 開發環境（gcc, g++, clangd）
- Neovim 配置

## 注意事項
- 運行腳本前必須完成 SSH 配置
- 需要 sudo 權限運行腳本
- 腳本會自動配置 Git 使用者信息
