# Checks for features are enabled on a bucket. Can be modified as needed.

#!/bin/bash

rm bucket-names.txt
rm versioning.txt

aws s3 ls --profile content | awk '{ print $3}' > bucket-names.txt

for BUCKETS in $(cat bucket-names.txt); do
        echo "Checking bucket $BUCKETS"
        ( echo $BUCKETS ; echo "" ; aws s3api get-bucket-encryption --bucket $BUCKETS --profile content ; echo "" ) >> versioning.txt 2>&1
done
