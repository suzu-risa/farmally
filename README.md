## Farmally

Farmallyは、農機具を探している人が、ほしい農機具の中古を探す依頼ができるサービスです。
このレポジトリは、ユーザーが農機具を検索し、中古品探しリクエストができるWebアプリのレポジトリです。

### 構成

いわゆるRailsとMySQLの簡単のWebアプリ構成です

- Lang: Ruby 2.5
- WAF: Ruby on Rails 5
- DB: MySQL7 (AWS Aurora) 
- Web Server: Nginx

### How to run

ローカル開発環境は、Dockerで作られています。
開発環境を立ち上げるには、まず以下のコマンドで、DBサービスを立ち上げます。

```
$ docker-compose up -d db
```

次に、railsのマイグレーション、テストデータの納入をします。

```
$ ./bin/rails db:create
$ ./bin/rails db:migrate
$ ./bin/rails db:seed
```

最後にサービスを立ち上げます。

```
$ ./bin/rails s 
```

### ステージング/本番環境について

### マスターデータ

https://docs.google.com/spreadsheets/d/14L6XAEhPKqdfldwQ0mD8HvxShdXRmMWSgJ7tMjV7aVI/edit#gid=0
