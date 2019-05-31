#!/bin/sh


# yesod の依存ライブラリインストール
yum -y install zlib-devel pcre-devel
# mySQLインストール
yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
yum -y install mysql mysql-devel mysql-server
service mysqld start

# MySQLの設定
# 初期パスワードを取得する
DB_PASSWORD=$(grep "A temporary password is generated" /var/log/mysqld.log | sed -s 's/.*root@localhost: //')
mysql -uroot -p${DB_PASSWORD} --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'rsYesodServer_2019'; flush privileges;"
# "Access denied for user 'myproject'@'localhost' (using password: YES)"}
mysql -uroot -prsYesodServer_2019 -e "CREATE DATABASE yesod_db CHARACTER SET utf8mb4;"
mysql -uroot -prsYesodServer_2019 -e "CREATE USER IF NOT EXISTS 'rsyesodserver'@'%' IDENTIFIED BY 'UgwD9_hwn3'"

service mysqld restart

