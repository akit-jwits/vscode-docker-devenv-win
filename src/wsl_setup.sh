# パッケージマネージャーでパッケージを更新する
sudo apt update
sudo apt upgrade -y

# Git のインストール
sudo apt install git

# Git の初期設定（設定値は引数を使用）
git config --global user.name "$1"
git config --global user.email "$2"

# Git が GitHub や AzureDevOps で多要素認証をできるようにする（Gitのバージョンによってここは変更が必要になる）
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
git config --global credential.https://dev.azure.com.useHttpPath true

# Docker のインストール（公式に記載の内容そのまま）
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Dockerを管理者じゃなくても実行できるようにユーザーを Docker グループに追加する
sudo gpasswd -a $USER docker

# クリーンアップ作業（容量軽減策）
sudo apt-get autoremove -y # インストール後不要になった依存パッケージの削除
sudo apt-get clean # キャッシュされたデータの削除
sudo rm -rf /var/lib/apt/lists/* # apt-get updateで取得したパッケージのリストを削除