[親文書](../README.md)

# WSL を開発で使用する準備

## セットアップ手順
必須ではないが利便性のため Microsoft もおすすめの [Windows Terminal](https://www.microsoft.com/store/productId/9N0DX20HK701) をインストールすることを推奨。

1. 管理者権限でコマンドプロンプトを開いてコマンドを実行
	- WLSのインストール  
		`wsl --install`
1. PCを再起動する
1. コマンドプロンプトを開いてコマンドを実行 ※管理者で実行する必要はない
	- WSLのアップデート  
		`wsl --update`
	- WSLの既定のバージョンを2にする（最初からなってると思うが念のため）  
		`wsl --set-default-version 2`
	- Ubuntuをインストールする  
		`wsl --install Ubuntu`
	- Ubuntuのユーザー名とパスワードの設定を求められるので入力する（Windowsと関係ないので覚えられるものを設定する）
	- Ubuntuから抜けるため、exit を入力する（logoutと表示される）  
	- Git・Dockerのインストールと初期設定
		- [wsl_setup.sh](../src/wsl_setup.sh) を任意の場所にダウンロード 
		- コマンドプロンプトでダウンロードした場所をカレントディレクトリにして以下を実行  
			`bash wsl_setup.sh <Git user name> <Git user email>`  
			
			※<> 部分はgit configで指定するのに使用する値。任意のものに書き換えて実行する。Windowsの設定とかとは無関係。GitHubで使うものがあればそれを設定するのが良い。  
			例：`bash wsl_setup.sh user_a user_a@domain.com`
	- Dockerの動作確認  
		- 以下のコマンドを実行  
			`wsl docker run hello-world`
			
# WSL の使い方
細かくいうと色々あるけど基本の3パターン。

- **Linux ターミナルを開く**
	- スタートメニューからUbuntuを実行

- **cmd（powershell）から利用する**
	- "wsl (実行したいコマンド)" を実行する  
	例：`wsl docker --version`
		
- **VSCode で利用する**
	- VSCode を開いて コマンドパレットを表示する（F1キーまたはCtrl+Shift+P）
	- "WSL" と入力して出てくる [WSLへの接続] を選ぶとUbuntu上でVSCodeを開いてくれる
		
WSL 環境で開発する（例えばGitリポジトリをクローンする）際のファイルの置き場所は以下を使用することを推奨する。  
\\wsl$\<DistroName>\home\<UserName>  

何故かというと、WSLのLinux環境から Windows フォルダー（例：\\wsl$\Ubuntu\mnt\c\の配下）を参照するとパフォーマンスが低下するため。WSL 用のフォルダーを直接参照するようにすると良い。


# 参考
WSL のインストール | Microsoft Learn  
https://learn.microsoft.com/ja-jp/windows/wsl/install  
WSL 開発環境を設定する | Microsoft Learn  
https://learn.microsoft.com/ja-jp/windows/wsl/setup/environment  
WSL で Git の使用を開始する | Microsoft Learn  
https://learn.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-git  
WSL で VS Code の使用を開始する | Microsoft Learn  
https://learn.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-vscode  
