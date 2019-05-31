#!/bin/sh

# stack のインストール
curl -sSL https://get.haskellstack.org/ | sh

# yesod のインストール
stack new rsyesodserver yesod-mysql
cd rsyesodserver
stack install yesod-bin --install-ghc
stack build

# DB設定を追加
export YESOD_MYSQL_USER='rsyesodserver'
export YESOD_MYSQL_PASSWORD='UgwD9_hwn3'
export YESOD_MYSQL_HOST='localhost'
export YESOD_MYSQL_DATABASE='yesod_db'

# yesod 起動
stack exec -- yesod devel
