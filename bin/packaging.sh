#!/usr/bin/env bash

export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_ACCOUNT_ID=306657763353
export APP_NAME=farmally

[ "$1" = "prod" ] && PROFILE=production || PROFILE=staging

# push gutenberg image
REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/tmyjoe/${APP_NAME}:${CIRCLE_SHA1}"
SECRET_KEY_BASE=$(aws s3 cp s3://farmally-secrets/secret_key_base.prod -)

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
    }
  ],
  "containerDefinitions": [
    {
      "name": "nginx-https-redirect",
      "image": "nginx",
      "essential": true,
      "memory": 128,
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
        },
        {
          "name": "SECRET_KEY_BASE",
          "value": "${SECRET_KEY_BASE}"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-region": "ap-northeast-1",
            "awslogs-group": "farmally-prod"
        }
      },
      "command": ["./bin/rails", "s"]
    },
    {
      "name": "nginx-proxy",
      "image": "nginx",
      "essential": true,
      "memory": 128,
      "portMappings": [
        {
          "hostPort": 80,
          "containerPort": 80
        }
      ],
      "links": [
        "farmally"
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
