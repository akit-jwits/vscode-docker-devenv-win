# vscode-docker-devenv-win
Windowsで VSCode ＆ WSL ＆ Docker を使用した開発環境を用意する方法をざっくりまとめる。基本的には身内用にまとめるので、偏った内容のため参考にされる方はご注意を。

最終的な構成はこんなイメージ。
![](images/overview.drawio.svg)

- 基本的にローカルに VSCode 以外のソフトウェアはインストールしない。
- 分かりにくいが VSCode は実質3つ存在する。それぞれに設定や拡張のインストールをすることになる。
    - ローカルの VSCode
    - WSL 上の VSCode
    - Container 上の VSCode
- ローカルの VSCode から、WSL や Container 上の VSCode に接続することができ、あたかもローカルの VSCode で作業をしているような操作感になる。


## 前提
以下手順の通り設定作業を終わらせていること。
1. [Visual Studio Codeのセットアップ](docs/Visual%20Studio%20Code%E3%81%AE%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97.md)
2. [WSLを開発で使用する準備](docs/WSL%E3%82%92%E9%96%8B%E7%99%BA%E3%81%A7%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B%E6%BA%96%E5%82%99.md)

## VSCodeでのDockerコンテナ環境準備に必要なもの
細かい仕様等はさておき、最低限必要なものの概要は以下。

- プロジェクト用のフォルダー直下に、`.devcontainer` フォルダーを作成する
- `.devcontainer` フォルダーに以下のファイルを用意する
    - `devcontainer.json` 
        - DevContainer 拡張の仕様に準ずる構成ファイル。        
        - dockerFile で Dockerfile や docker-compose を Docker の構成に使用することを指定できる。
        - コンテナ上の VSCode にインストールする拡張機能を指定できる。
        - Docker コンテナの実行の引数などを指定できる。
    - Docker 構成ファイル群
        - Dockerfile や `compose.yaml` など、Docker 等の仕様に準ずるもの。
        - Docker のイメージ（設計書的なもの）を定義する。

実装サンプルは以下。  
- Python開発用  
https://github.com/akit-jwits/vscode-devcontainer-sample-python
- PySpark動作確認用  
https://github.com/akit-jwits/vscode-devcontainer-sample-pyspark


## VSCodeでDockerコンテナを作成して使用する方法
基本的には、上記のコンテナ環境準備が済んだフォルダーを開くところから始まるので、準備が済んでいることを前提とする。  
以下の説明で出てくる コマンドパレット は F1 キーまたは Ctrl＋Shift＋P で表示できる。

### ローカルのフォルダーを開く
[WSLを開発で使用する準備](docs/WSL%E3%82%92%E9%96%8B%E7%99%BA%E3%81%A7%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B%E6%BA%96%E5%82%99.md) にも記載の通り、まずは WSL のストレージにファイルを配置していることを前提とする。

1. VSCode を開いた後、左下の >< 部分（青い部分）をクリックして [WSL への接続] を選ぶ
1. あとは VSCode のエクスプローラーで [フォルダーを開く] を押して、ファイルを配置しているフォルダーを開く
1. 右下に通知が表示されるので、[コンテナーで再度開く] を選ぶ
1. 右下の通知を見逃した場合、VSCode 左下の >< 部分（青い部分）をクリックして、[コンテナーで再度開く] を選ぶとよい

この方法を使うと、WSL のストレージフォルダーをコンテナでマウントして使用するので、コンテナ上で編集したファイルの変更は WSL からも ローカル（Windows）からも参照できる。

### Gitリポジトリをクローンして開く
対象のGitリポジトリに準備済みのフォルダー・ファイルがある前提。  

1. コマンドパレットで "clone repo"と入力して出てくる [開発コンテナー: コンテナーボリュームにリポジトリを複製] を選ぶ

この方法を使うと、リポジトリのクローン（ファイル等）はコンテナ内で管理されるため、WindowsやWSLからクローンしたファイルにアクセスすることはない。すべてのリソースをコンテナごとに管理できるという点はメリットとも言える。  

この方法で開いたフォルダーを再び開きたい場合は、[最近使用した項目を開く]から開くのが最も簡単。説明は割愛するが、コンテナにVSCodeをアタッチする方法もある。

### コンテナやWSLへの接続を終了する
1. VSCode左下の >< 部分（青い部分）をクリックする
1. 画面上部にメニューが出るので、[リモート接続を終了する] を選ぶとWSL・コンテナとの接続を終わる。[WSLへの接続] を選ぶとWSLへ接続した状態は維持される。

### コンテナを管理する
VSCodeでWSLに接続した状態で [Docker 拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) をインストールすると WSL に接続した状態の VSCode を使えば GUI で Docker イメージやコンテナを管理できる。  

Docker のアイコンから Docker イメージやコンテナを参照したり、消したりできる。当然ながらどちらも容量を食うので、必要ない場合は消すとよい。
元になっているファイルさえあれば同じ環境はいつでも手間なく再構築できる。




