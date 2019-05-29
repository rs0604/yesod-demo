-- 初回のパスワードポリシーを満たすパスワードを設定（適当でよい）
SET password FOR root@localhost=password('uQvdquWj3=bW');

-- パスワードポリシーの変更
SET global validate_password_policy=LOW;
SET global validate_password_length=6;
-- パスワードの変更
SET password FOR root@localhost=password('vagrant');

-- ユーザーの作成
CREATE USER yesod_server@localhost identified BY 'yesod_server_dev';
-- データベースの作成
CREATE database yesod_db;
-- テーブルの作成
CREATE TABLE IF NOT EXISTS `yesod_db`.`users` (`user_id` INT NOT NULL COMMENT '',
`is_deleted` TINYINT NOT NULL COMMENT '',
`updated_at` TIMESTAMP COMMENT '',
PRIMARY KEY (`user_id`) COMMENT '',
UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) COMMENT '')
ENGINE = InnoDB;

-- 権限の付与（IPアドレスによるアクセス元の制限は指定しない）
GRANT ALL ON *.* TO 'yesod_server'@'localhost' IDENTIFIED BY 'yesod_server_dev';
GRANT ALL ON *.* TO 'yesod_server'@'%' IDENTIFIED BY 'yesod_server_dev';
FLUSH PRIVILEGES;
