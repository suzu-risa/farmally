#!/usr/bin/env bash

export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_ACCOUNT_ID=306657763353
export APP_NAME=farmally
export WP_NAME=farmally-wp

[ "$1" = "prod" ] && PROFILE=production || PROFILE=staging

REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/tmyjoe/${APP_NAME}:${CIRCLE_SHA1}"
WP_REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${WP_NAME}:${CIRCLE_SHA1}"

MYSQL_USERNAME=`bin/rails r "print Rails.application.credentials[${PROFILE}.to_sym][:mysql_username]"`
MYSQL_PASSWORD=`bin/rails r "print Rails.application.credentials[${PROFILE}.to_sym][:mysql_password]"`

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
      "name": "nginx-redirect-conf",
      "host": {
        "sourcePath": "/var/app/current/nginx-redirect"
      }
    },
    {
      "name": "wp-data",
      "host": {
        "sourcePath": "/var/app/current/wp-data"
      }
    }
  ],
  "containerDefinitions": [
    {
      "name": "nginx-https-redirect",
      "image": "nginx",
      "essential": true,
      "memory": 64,
      "portMappings": [
        {
          "hostPort": 81,
          "containerPort": 80
        }
      ],
      "mountPoints": [
        {
          "sourceVolume": "nginx-redirect-conf",
          "containerPath": "/etc/nginx/conf.d",
          "readOnly": true
        },
        {
          "sourceVolume": "awseb-logs-nginx-proxy",
          "containerPath": "/var/log/nginx"
        }
      ]
    },
    {
      "name": "farmally",
      "image": "${REPO}",
      "essential": true,
      "memory": "512",
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
      "memory": 64,
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
          "containerPath": "/var/www/html",
          "readOnly": true
        }
      ]
    },
    {
      "name": "wordpress",
      "image": "${WP_REPO}",
      "essential": true,
      "memory": 256,
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
          "value": "wordpress_${RROFILE}"
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
          "containerPath": "/var/www/html"
        }
      ]
    }
  ]
}
EOS


mkdir bundle
chmod -R 777 bundle
cp -r .ebextensions ./bundle/.ebextensions
cp -r ./nginx ./bundle/nginx
cp -r ./nginx-redirect ./bundle/nginx-redirect
cp Dockerrun.aws.json bundle/
cd bundle
zip -r build.zip .
cd ..
cp ./bundle/build.zip ./
