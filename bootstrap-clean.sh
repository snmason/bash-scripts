# cleans up the resources created via cdk bootstrap process.
# Requires credentials with permissions to delete cloudformation and s3 resources. 

#!/bin/bash

while true; do 

read -p "Use default region ${AWS_REGION}? (y/n) " yn

case $yn in
  [Yy] ) 
    CDK_REGION=${AWS_REGION}
    break
    ;;
  [Nn] )
    echo "Confirm region you deployed to"
    read -p "Region: " CDK_REGION
    break
    ;;
  * )
    echo 'Invalid answer'
    ;;
esac
done

echo "deleting cloudformtion stack"
aws cloudformation delete-stack --stack-name CDKToolkit --region="$CDK_REGION"

echo "removing S3 bucket"
BUCKET=$(aws s3 ls | grep -o "cdk.*${CDK_REGION}$")
aws s3 rb --force s3://"$BUCKET"
