## Farmally

Farmallyは、農機具を探している人が、ほしい農機具の中古を探す依頼ができるサービスです。
このレポジトリは、ユーザーが農機具を検索し、中古品探しリクエストができるWebアプリのレポジトリです。

### 構成

いわゆるRailsとMySQLの簡単のWebアプリ構成です

- Lang: Ruby 2.5.1
- WAF: Ruby on Rails 5.2.0
- DB: MySQL5.7 (AWS Aurora)
- Web Server: Nginx

### How to run

クレデンシャルの設定を読み込めるように  
[コンフル : 機微情報](https://confl.arms.dmm.com/pages/viewpage.action?pageId=443186687) から
`master.key` をダウンロードし、`/config/` 配下に配置してから作業ください。

ローカル開発環境は、Dockerで作られています。
開発環境を立ち上げるには、まず以下のコマンドで、DBサービスを立ち上げます。

```
$ docker-compose up -d db
```

次に、railsのマイグレーション、テストデータの納入をします。

```
$ docker-compose run farmally rails db:create
$ docker-compose run farmally rails db:migrate
$ docker-compose run farmally rails db:seed
```

サービスを立ち上げます。

```
$ docker-compose up -d
```

ローカル環境にHOSTS設定を追加します

```
127.0.0.1   local-nouki.dmm.com
127.0.0.1   local-farmally.com
```

http://local-nouki.dmm.com にアクセスできれば環境構築完了です。

### rspec
```
$ bin/rspec
```
※rspecは現在流していません。

### ステージング/本番環境について

ステージング/本番環境は、AWS上に構築されています。
アプリケーションはElastic Beanstalkにデプロイされており、DockerizeされたRailsアプリケーションコンテナ、Nginxコンテナをデプロイします。
それぞれの環境のURLは以下の通りです。

- ステージング: https://staging.farmally.jp
- 本番:  https://farmally.jp

デプロイはCircleCIによって自動化されています。
ステージング環境へは、Developブランチへ更新があるたびに、ビルド、デプロイが走るように設定されています。
本番環境は、vX.X.Xの形式 (Xは数字) でタグを打つと、そのタグに対して、ビルド、デプロイが走ります。マスターへマージしてからタグを打つと良いでしょう。

デプロイのフローについてより理解したい場合は、以下を参照してください。

* [CircleCIのConfig](https://github.com/farmally/farmally/blob/develop/.circleci/config.yml)
* [DockerイメージのパブリッシュScript](https://github.com/farmally/farmally/blob/develop/bin/publish.sh)
* [EBのパッケージングスクリプト](https://github.com/farmally/farmally/blob/develop/bin/packaging.sh)
* [デプロイスクリプト](https://github.com/farmally/farmally/blob/develop/bin/deploy.sh)

### マスターデータ

https://docs.google.com/spreadsheets/d/14L6XAEhPKqdfldwQ0mD8HvxShdXRmMWSgJ7tMjV7aVI/edit#gid=0
