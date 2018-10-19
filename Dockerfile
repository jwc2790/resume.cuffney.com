FROM ubuntu:latest

# update and upgrade packages
RUN apt-get update \
  && apt-get upgrade -y

# isntall packages
RUN apt-get install -y \
    pandoc \
    python-pip

# install aws-sdk (uses pip)
RUN pip install awscli --upgrade --user
