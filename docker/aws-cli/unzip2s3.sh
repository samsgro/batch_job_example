#!/bin/bash

#!/bin/bash


BUCKET=$1
KEY=$2
echo $BUCKET/$KEY
export PATH=/root/.local/bin/:$PATH

# Download zip file

/root/.local/bin/aws s3 cp s3://$BUCKET/$KEY ./

# Extract the file name and directory name from S3 key

DIRNAME=$(find . -name "*.zip" | cut -f 2 -d '.' | cut -f 2 -d "/")
FILENAME=$(find . -name "*.zip")

echo $DIRNAME $FILENAME

# Create directory and decompress file in it

mkdir $DIRNAME
unzip $FILENAME -d ./$DIRNAME/
ls -la $DIRNAME

# Upload extract into s3 key for outpupt

/root/.local/bin/aws s3 cp --recursive ./$DIRNAME/ s3://$BUCKET/artifacts/snapshots/job_output/$DIRNAME/


