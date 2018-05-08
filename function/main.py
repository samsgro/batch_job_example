import boto3

def entrypoint(event, context):
  client = boto3.client('batch', 'us-west-2')
  response = client.submit_job(
      jobName='lambda-unzip2s3',
      jobQueue='batch-wos-job-queue-u6047692',
      arrayProperties={
          'size': 10
      },
#      dependsOn=[
#          {
#              'jobId': 'string',
#              'type': 'N_TO_N'|'SEQUENTIAL'
#          },
#      ],
      jobDefinition='batch_wos_job_definition',
#      parameters={
#          'string': 'string'
#      },
      containerOverrides={
          'vcpus': 1,
          'memory': 512,
          'command': [
              './unzip2s3.sh',
         ],
          'environment': [
              {
                  'name': 'BUCKET',
                  'value': 'clarivate.wos.dev.us-west-2.build-tools'
              },
              {
                  'name': 'KEY',
                  'value': 'artifacts/snapshots/job_input/batch_job_scheduler.zip'
              }
          ]
      },
      retryStrategy={
          'attempts': 3
      },
      timeout={
          'attemptDurationSeconds': 90
      }
  )
