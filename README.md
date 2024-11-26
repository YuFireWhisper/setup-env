# Development Environment Setup

個人開發環境配置腳本，用於快速配置新環境。

## 支援的系統
- Ubuntu

## 使用方法

### Ubuntu
1. 確保已安裝 git 並配置好 SSH
2. 克隆倉庫：
   ```bash
   git clone git@github.com:YuFireWhisper/dev-setup.git -b ubuntu
   ```
3. 進入目錄：
   ```bash
   cd dev-setup
   ```
4. 給腳本執行權限：
   ```bash
   chmod +x setup-dev-env.sh
   ```
5. 運行腳本：
   ```bash
   sudo ./setup-dev-env.sh
   ```

## 包含的配置
- 基本開發工具（git, curl, wget, tree）
- Python 環境
- Node.js
- C/C++ 開發環境（gcc, g++, clangd）
- Neovim 配置

## 注意事項
- 運行前確保 SSH key 已放置在 ~/.ssh/ 目錄
- 需要 sudo 權限運行腳本
