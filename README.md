# Resume

> Resume is versioned in markdown, and built into html, docx, plain text, and pdf formats using pandoc.

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

#### Uploading to AWS ECR

0. Authenticate with ECR and create the repository if it dosen't exist already.

`$(aws ecr get-login --no-include-email --region us-east-1 --profile cuffney)`

`aws ecr --profile cuffney create-repository --repository-name cuffney/resume`

1. Tag the image:

`docker tag <Docker Image Id> 255964265911.dkr.ecr.us-east-1.amazonaws.com/cuffney/resume:latest`

2. Push the image to ECR:

`docker push 255964265911.dkr.ecr.us-east-1.amazonaws.com/cuffney/resume:latest`