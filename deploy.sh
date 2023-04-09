#!/bin/bash

export MAIN_DIRECTORY=$PWD

export BUCKET_NAME=fidelis-cdk-builds
export BUCKET_PREFIX=image-handler
export VERSION=6.1.1

cd $MAIN_DIRECTORY/deployment

./build-s3-dist.sh $BUCKET_PREFIX $SOLUTION_NAME $VERSION

aws s3 sync global-s3-assets/ s3://$BUCKET_NAME/$SOLUTION_NAME/$VERSION
aws s3 sync regional-s3-assets/ s3://$BUCKET_NAME/$SOLUTION_NAME/$VERSION

aws cloudformation create-stack --stack-name dev-image-handler --template-url https://fidelis-cdk-builds.s3.ap-southeast-1.amazonaws.com/image-handler/6.1.1/image-handler.template --capabilities CAPABILITY_IAM

