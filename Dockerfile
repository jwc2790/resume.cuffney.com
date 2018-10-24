FROM ubuntu:latest

# update and upgrade packages
RUN apt-get update \
  && apt-get upgrade -y

COPY src/ /tmp/

# isntall packages
RUN apt-get install -y \
    pandoc \
    python-pip \
    texlive-latex-recommended \ 
    texlive-latex-extra

# install aws-sdk (uses pip)
RUN pip install awscli --upgrade --user
