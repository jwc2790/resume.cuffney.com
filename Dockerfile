FROM ubuntu:latest

# update and upgrade packages
RUN apt-get update \
  && apt-get upgrade -y

COPY ./resume.md /tmp/

# isntall packages
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq \
    awscli \
    pandoc
    # python-pip
    # texlive-latex-recommended \ 
    # texlive-latex-extra

# install aws-sdk (uses pip)
# RUN pip install awscli --upgrade --user
