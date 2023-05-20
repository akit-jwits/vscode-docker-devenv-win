[親文書](../README.md)
# Visual Studio Codeのセットアップ

## Visual Studio Codeのインストール
Microsoft Storeからインストールする。管理者権限は不要。  
https://apps.microsoft.com/store/detail/XP9KHM4BK9FZ7Q

# VSCode拡張のインストール
## 必須
- **WSL**  
用途：WSL（Linux）を用いた開発環境の利用  
https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl

- **Dev Containers**  
用途：Dockerを用いた開発環境の利用  
https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

## 推奨
- **Japanese Language Pack for Visual Studio Code**  
用途：VSCode日本語化  
https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-ja

- **vscode-icons**  
用途：エクスプローラーペインの視認性（特にフォルダー）が良くなるので必須ではないが推奨  
https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons


# 設定の変更
- VSCodeの左下の歯車ボタンから [設定] を選択する
- 以降、画面上部の [設定の検索] 欄に以下の設定のIDを入力し、設定を変更する  
`dev.containers.executeInWSL`： チェックをONにする（CLIコマンドを常にWSLで実行する）
		
