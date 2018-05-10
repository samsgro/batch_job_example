![alt text](batch-service-diagram.png "Description goes here")

## AWS batch service for SAR as IaaS

This is a service that will be available to anyone in SAR. ** **Still under development** ** The final form of this service will provide a fully automated pipeline to deploy in non-prod and prod environments, following clarivates naming and tagging conventions. In the dev environment (when deployed from local computer), all resources deployed will be lable with the employer id to trace back the person who originate them in case of leaving them idle.

### The resources

The deployment of the resources is divided in three sections:
* Global: consisting of all mostly permanent resources like IAM policies, roles, SG, etc. And are located in ```infrastructure/<ENV>/global/```
* Batch Service: here the compute environment and other resources related to the service are define and created. ```infrastructure/<ENV>/batch_service/```
* Scheduler: consisting of a lambda function and all its IAM roles needed to create and submit a batch job triggered by and object uploaded to S3. ```infrastructure/<ENV>/job_scheduler/``` 

### How to deploy this demo?

This demo deploys a batch service, and the supporting resources, to be trigger by a zip file uploaded to ```s3://clarivate.wos.dev.us-west-2.build-tools/artifacts/snapshots/job_input/```. Please refere to this [repository](https://github.com/bvcotero/wos-shared-bucket) for instructions on how to upload files to the bucket ```clarivate.wos.dev.us-west-2.build-tools```. The unpackaged content of the zip file will be uploaded to ```s3://clarivate.wos.dev.us-west-2.build-tools/artifacts/snapshots/job_output/<zip_file_name>/```.

Follow this steps to deploy resources manually:
* ```cd infrastructure/dev/global```
* ```terraform plan``` and check what will be deployed.
* ```terraform apply```

**NOTE:** The output of this deployment will list the ```ecr_unzip_name``` and ```ecr_unzip_repository_url``` that will be used to upload the image to ECR. You can always retrieve this list by running ```terraform output``` in this directory.

* ```cd ../batch_service```
* ```terraform plan``` and ```terraform apply```

Create the zip package for the lambda function:
* ```cd ../../../function```
* ```mkdir lib```
* ```pip install -r requirements.txt -t ./lib/```
* ```cd lib``` and ```zip -r ../batch_job_scheduler.zip *```
* ```cd ..``` and ```zip -9 batch_job_scheduler.zip ./main.py```

Deploy the lambda scheduler:
* ```cd ../infrstructure/dev/job_scheduler```
* ```terraform plan``` and ```terraform apply```

Now let's upload the image to the ECR repository: 
* ```cd ../../../docker/fn-unzip2s3```
* ```eval $(aws ecr get-login --no-include-email --region us-west-2 --profile wos-dev | sed 's|https://||')```
* ```docker build -t <ecr_unzip_name> .```
* ```docker tag <ecr_unzip_name>:latest <ecr_unzip_repository_url>:latest```
* ```docker push <ecr_unzip_repository_url>:latest```

Go to AWS console and find all the resources deployed, also check the ECS cluster that is deploy and that will be used by the batch service, and there will be one instance associated to the ECS and batch service.

Now upload to s3 the zip file you created for lambda as a test file, and check the batch service dash board and the jobs that are schedule. Additional EC2 instances will be created. Also check the logs to see the output of the jobs that have run.

