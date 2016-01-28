#!/bin/bash

cd ~

#--------------------------------------------------
# Install aws
#--------------------------------------------------
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm -Rf awscli-bundle
rm -Rf awscli-bundle.zip
export PATH=$PATH:/usr/local/bin
aws --version

#--------------------------------------------------
# Configure aws
#--------------------------------------------------
echo "\n---- Configure aws ----"
echo "\n AWS Access Key -> https://console.aws.amazon.com/iam"
aws configure