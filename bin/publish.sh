#! /bin/bash

# setup aws profile
set -x
set -e

export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_ACCOUNT_ID=306657763353
export APP_NAME=farmally

# push gutenberg image
REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/tmyjoe/${APP_NAME}:${CIRCLE_SHA1}"
REPO_LATEST="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/tmyjoe/${APP_NAME}:latest"

aws s3 cp s3://farmally-secrets/master.key config/master.key

docker build -t ${REPO} .
docker tag ${REPO} ${REPO_LATEST}

login_cmd=`aws ecr get-login --region $AWS_DEFAULT_REGION --no-include-email`
eval $login_cmd

echo "Start pushing to $REPO"
docker push ${REPO}
docker push ${REPO_LATEST}
