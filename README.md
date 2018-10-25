# Resume

> Resume is versioned in markdown, and built into html, docx, plain text, and pdf formats using pandoc.

![Build Status](https://codebuild.us-east-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiUVAvY0lqTTdTS1ROek9VVjZka2tSc1JFTFd4cWp5RWVpUE5PaDRqYVBKMFFBT0xLSzUrSVFEdmxabTlDdmV0bklFVDBoVGltZmRPQzdSTDBwK3dkaEF3PSIsIml2UGFyYW1ldGVyU3BlYyI6Im5rVHVKRmtlSFlYN3huR1IiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)

## Writing Resume Versions / Updating resumes. 

1. Write your resume / updates in markdown within `src/resumes`.
2. Commit your changes.
3. push changes to GitHub.

## CI Pipline (AWS Code Pipeline)

1. Source
2. Build (AWS Codebuild)
   - Should report build status's back to Github.
   - run build in custom docker image with `pandoc` installed.
     1. Generate all resume formats
     2. Copy output to `/public` directory
     3. Deploy `/public` to `resume.cuffney.com` S3 Bucket. (seperate stack.)
     4. Invalidate CloudFront 

## Infrastrucutre

- ArtifactBucket
- CodePipeline
- CodeBuild

## Docker Development

#### Building the Docker Image

`docker build . -t cuffney/resume:latest`

#### Running the image Locally to Test

`docker run -it cuffney/resume:latest /bin/bash`

#### Uploading to AWS ECR

1. Authenticate with ECR and create the repository if it dosen't exist already.

`$(aws ecr get-login --no-include-email --region us-east-1 --profile cuffney)`

`aws ecr --profile cuffney create-repository --repository-name cuffney/resume`

NOTE: you'll need to add permissions to the ECR repository so that codebuild has access to pull the image. Follow the instructions here to do so: https://docs.aws.amazon.com/codebuild/latest/userguide/sample-ecr.html

2. Tag the image:

`docker tag <Docker Image Id> 255964265911.dkr.ecr.us-east-1.amazonaws.com/cuffney/resume:latest`

3. Push the image to ECR:

`docker push 255964265911.dkr.ecr.us-east-1.amazonaws.com/cuffney/resume:latest`
