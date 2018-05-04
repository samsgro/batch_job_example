import boto3

def entrypoint(event, context):
  client = boto3.client('batch', 'us-west-2')
  response = client.submit_job(
      jobName='test-lambda',
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
          'memory': 4,
          'command': [
              'ls',
#          ],
#          'environment': [
#              {
#                  'name': 'string',
#                  'value': 'string'
#              },
          ]
      },
      retryStrategy={
          'attempts': 3
      },
      timeout={
          'attemptDurationSeconds': 90
      }
  )
