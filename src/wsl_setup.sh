echo ■ DNS設定の変更
# WSLの不具合で名前解決に失敗する挙動への対応 
# ※環境によってこの対応は不要
# 参考：
# https://github.com/microsoft/WSL/issues/5420
# https://github.com/microsoft/WSL/issues/8365
# [boot]のコマンドは1行でしか書けない。resolve.confに複数行書きたい場合はechoの -e オプションと`\n`の利用などを検討用
sudo tee /etc/resolv.conf <<EOF >/dev/null
nameserver 8.8.8.8
EOF
sudo tee /etc/wsl.conf <<EOF >/dev/null
[network]
generateResolvConf = false
[boot]
command = echo "nameserver 8.8.8.8" > /etc/resolv.conf
EOF

echo ■ パッケージマネージャーでパッケージを更新
sudo apt -qq update
sudo apt -qq upgrade -y

echo ■ Git のインストール・初期設定
sudo apt -qq install git

# 設定値は引数を使用
git config --global user.name "$1"
git config --global user.email "$2"

# Git が GitHub や AzureDevOps で多要素認証をできるようにする
# ※Windowsにインストール済みのGitのバージョンやインストール先によってここは変更が必要になる
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
git config --global credential.https://dev.azure.com.useHttpPath true

echo ■ Docker のインストール
# 公式に記載の内容そのまま（gpg -dearmorの部分だけ "--yes" を追記、aptの-qqオプションも追加）
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get -qq install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get -qq update

sudo apt-get -qq install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

echo ■ Docker の実行権限設定
sudo gpasswd -a $USER docker # dockerグループにユーザーを追加

echo ■ クリーンアップ
# WSLの容量軽減策
sudo apt-get autoremove -y # インストール後不要になった依存パッケージの削除
sudo apt-get clean # キャッシュされたデータの削除
sudo rm -rf /var/lib/apt/lists/* # apt-get updateで取得したパッケージのリストを削除