FROM ubuntu

LABEL "maintainer_name"="Berenice Venegas Cotero" \
      "maintainer_email"="berenice.cotero@clarivate.com"

#ENV BUCKET clarivate.wos.dev.us-west-2.build-tools
#ENV KEY artifacts/snapshots/job_input/batch_job_scheduler.zip
ENV PREFIX_OUTPUT artifacts/snapshots/job_output

RUN apt-get update && \
    apt-get install -y python ca-certificates groff curl zip unzip less && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    pip install awscli --upgrade --user

RUN export PATH=/root/.local/bin:$PATH
RUN /root/.local/bin/aws --version

#ADD ./unzip2s3.sh ./unzip2s3.sh
RUN /root/.local/bin/aws s3 cp s3://clarivate.wos.dev.us-west-2.build-tools/artifacts/snapshots/scripts/unzip2s3.sh ./unzip2s3.sh
RUN chmod 777 ./unzip2s3.sh

CMD ["bin/bash"]