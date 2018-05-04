FROM alpine:3.6

# Versions: https://pypi.python.org/pypi/awscli#downloads
ENV AWS_CLI_VERSION 1.11.131

RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates groff less && \
    pip install --upgrade pip && \
    pip --no-cache-dir install awscli==${AWS_CLI_VERSION} && \
    rm -rf /var/cache/apk/*
ENV BUCKET_KEY "clarivate.wos.dev.us-west-2.build-tools/artifacts/snapshots/job_output/"


RUN aws s3 cp s3://clarivate.wos.dev.us-west-2.build-tools/artifacts/snapshots/job_input/batch_job_scheduler.zip ./

RUN mkdir $(find . -name "*.zip" | cut -f 2 -d '.' | cut -f 2 -d "/")

RUN unzip $(find . -name "*.zip") -d ./$(find . -name "*.zip" | cut -f 2 -d '.' | cut -f 2 -d "/")/

RUN aws s3 cp --recursive ./$(find . -name "*.zip" | cut -f 2 -d '.' | cut -f 2 -d "/")/ s3://$BUCKET_KEY

