#!/usr/bin/env bash

AWS_DEFAULT_REGION=ap-northeast-1
AWS_ACCOUNT_ID=306657763353
APP_NAME=farmally
WP_NAME=farmally-wp

[ "$1" = "prod" ] && PROFILE=production || PROFILE=staging

# push gutenberg image
REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/tmyjoe/${APP_NAME}:latest"
WP_REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${WP_NAME}:latest"

bundle install --path vendor/bundle
[ ! -e .bundle ] && mkdir .bundle
[ -e .bundle/config ] && rm .bundle/config
echo "---" >> .bundle/config
echo "BUNDLE_PATH: \"vendor/bundle\"" >> .bundle/config
MYSQL_USERNAME=`./bin/rails r "print Rails.application.credentials['${PROFILE}'.to_sym][:mysql_username]"`
MYSQL_PASSWORD=`./bin/rails r "print Rails.application.credentials['${PROFILE}'.to_sym][:mysql_password]"`

[ $PROFILE = 'production' ] && RAILS_MEMORY=1024 || RAILS_MEMORY=512
[ $PROFILE = 'production' ] && NGINX_MEMORY=256 || NGINX_MEMORY=128
[ $PROFILE = 'production' ] && WP_MEMORY=512 || WP_MEMORY=256

[ -e Dockerrun.aws.json ] && rm Dockerrun.aws.json

cat > Dockerrun.aws.json <<EOS | jq
{
  "AWSEBDockerrunVersion": 2,
  "volumes": [
    {
      "name": "nginx-proxy-conf",
      "host": {
        "sourcePath": "/var/app/current/nginx"
      }
    },
    {
      "name": "wp-data",
      "host": {
        "sourcePath": "/efs"
      }
    }
  ],
  "containerDefinitions": [
    {
      "name": "farmally",
      "image": "${REPO}",
      "essential": true,
      "memory": ${RAILS_MEMORY},
      "environment": [
        {
          "name": "RAILS_ENV",
          "value": "${PROFILE}"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-region": "ap-northeast-1",
            "awslogs-group": "farmally-${PROFILE}"
        }
      },
      "command": ["./bin/start.sh"]
    },
    {
      "name": "nginx-proxy",
      "image": "nginx",
      "essential": true,
      "memory": ${NGINX_MEMORY},
      "portMappings": [
        {
          "hostPort": 80,
          "containerPort": 80
        }
      ],
      "links": [
        "farmally",
        "wordpress"
      ],
      "mountPoints": [
        {
          "sourceVolume": "nginx-proxy-conf",
          "containerPath": "/etc/nginx/conf.d",
          "readOnly": true
        },
        {
          "sourceVolume": "awseb-logs-nginx-proxy",
          "containerPath": "/var/log/nginx"
        },
        {
          "sourceVolume": "wp-data",
          "containerPath": "/var/www/html/blog",
          "readOnly": true
        }
      ]
    },
    {
      "name": "wordpress",
      "image": "${WP_REPO}",
      "essential": true,
      "memory": ${WP_MEMORY},
      "environment": [
        {
          "name": "WORDPRESS_SUBDIRECTORY",
          "value": "blog"
        },
        {
          "name": "WORDPRESS_DB_HOST",
          "value": "farmally.csnop7esfbay.ap-northeast-1.rds.amazonaws.com:3306"
        },
        {
          "name": "WORDPRESS_DB_NAME",
          "value": "wordpress_${PROFILE}"
        },
        {
          "name": "WORDPRESS_DB_USER",
          "value": "${MYSQL_USERNAME}"
        },
        {
          "name": "WORDPRESS_DB_PASSWORD",
          "value": "${MYSQL_PASSWORD}"
        }
      ],
      "mountPoints": [
        {
          "sourceVolume": "wp-data",
          "containerPath": "/var/www/html/blog"
        }
      ]
    }
  ]
}
EOS

mkdir bundle
chmod -R 777 bundle
cp -r .ebextensions ./bundle/.ebextensions
if [ $PROFILE = 'production' ]; then
  sed -i '' -e 's/fs-.*:\//fs-0ff61f2e:\//g' ./bundle/.ebextensions/01-efs-mount.config
fi
cp -r ./nginx ./bundle/nginx
cp Dockerrun.aws.json bundle/
cd bundle
zip -r build.zip .
cd ..
cp ./bundle/build.zip ./

# clean up
[ -e bundle ] && rm -rf bundle
[ -e Dockerrun.aws.json ] && rm Dockerrun.aws.json
[ -e .bundle/config ] && rm .bundle/config
