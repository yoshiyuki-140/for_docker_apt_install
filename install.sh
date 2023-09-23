#!/bin/bash
# 参考にしたサイト:https://kinsta.com/jp/blog/install-docker-ubuntu/

# 
#!/bin/bash

# チェックするファイルのパスを設定
file_path="/etc/apt/keyrings/docker.gpg"


# 既存パッケージのアップデート
sudo apt update
# 依存関係のインストール
sudo apt install 
# DockerのGPGの鍵をaptに登録する
# これで、aptによる、インストールしたDockerパッケージの検証が可能になる

# ファイルが存在しない場合にコマンドを実行
if [ ! -e "$file_path" ]; then
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg


	# 実行すると、シェルの置換を利用して、AMD64やARM64など、システムのアーキテクチャが自動で検出され、
	# パッケージ情報がダウンロードされます。先ほど追加したGPG鍵を用いて認証が行われ、
	# リポジトリが、新たなパッケージリストとしてapt /etc/apt/sources.list.d directory.に追加されます。
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	
fi
# aptがDockerパッケージの存在を検出できるよう、パッケージ情報を再度更新します。
sudo apt update

# やっとインストールすることができるようになったので、する。
# docker-ce：Docker Engineのデーモン
# docker-ce-cli：操作することになるDocker CLI
# containerd.io：コンテナの起動と実行に利用するコンテナランタイム/ソフトウェア（containerd）
sudo apt install docker-ce docker-ce-cli containerd.io
