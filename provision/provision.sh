#!/bin/sh

# mySQLインストール
yum -y install mysql mysql-devel mysql-server
# yesod の依存ライブラリインストール
yum -y zlib-devel pcre-devel

# MySQLの設定
service mysqld start

# 初期パスワードを取得する
DB_PASSWORD=$(grep "A temporary password is generated" /var/log/mysqld.log | sed -s 's/.*root@localhost: //')
mysql -u root -p ${DB_PASSWORD} --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'rsYesodServer_2019'; flush privileges;"
# "Access denied for user 'myproject'@'localhost' (using password: YES)"}
mysql -u root -p rsYesodServer_2019 -e "CREATE DATABASE yesod_db CHARACTER SET utf8mb4;"
mysql -u root -p rsYesodServer_2019 -e "CREATE USER IF NOT EXISTS 'rsyesodserver'@'%' IDENTIFIED BY 'UgwD9_hwn3'"
# stack のインストール
curl -sSL https://get.haskellstack.org/ | sh
export PATH="/usr/local/bin:$PATH"

# yesod のインストール
stack new rsyesodserver yesod-mysql
cd rsyesodserver
stack install yesod-bin --install-ghc
stack build

# yesod 起動
stack exec -- yesod devel

