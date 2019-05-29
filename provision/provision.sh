#!/bin/sh

lookFile=/home/vagrant/provisioner.lock
if [ -e $lookFile ]; then
    exit
fi

touch $lookFile

# mariaDBとの競合を防ぐため
yum -y remove mariadb-libs
rm -rf /var/lib/mysql

# https://dev.mysql.com/downloads/repo/yum/を参照
yum -y localinstall http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum -y install mysql-community-server

# 必要最小限のMySQLの設定内容を書き込む
cat << __CONF__ >> /etc/my.cnf
character-set-server = utf8
default_password_lifetime = 0
__CONF__

# MySQLの自動起動を有効化し起動する
systemctl enable mysqld
systemctl start mysqld
# 初期パスワードを取得する
password=`cat /var/log/mysqld.log | grep "A temporary password" | tr ' ' '\n' | tail -n1`

mysql -u root -p${password} --connect-expired-password < /vagrant/provisioner.sql
