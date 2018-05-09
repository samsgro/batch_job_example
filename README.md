![alt text](batch-service-diagram.png "Description goes here")

## AWS batch service for SAR as IaaS

This is a service that will be available to anyone in SAR. ** Still under development ** The final form of this service will provide a fully automated pipeline to deploy in non-prod and prod environments, following clarivates naming and tagging conventions. In the dev environment (when deployed from local computer), all resources deployed will be lable with the employer id to trace back the person who originate them in case of leaving them idle.

### The resources

The deployment of the resources is divided in three sections:
* Global: consisting of all mostly permanent resources like IAM policies, roles, SG, etc. And are located in ```infrastructure/<ENV>/global/```
* Batch Service: here the compute environment and other resources related to the service are define and created. ```infrastructure/<ENV>/batch_service/```
* Scheduler: consisting of a lambda function and all its IAM roles needed to create and submit a batch job triggered by and object uploaded to S3. ```infrastructure/<ENV>/job_scheduler/``` 
