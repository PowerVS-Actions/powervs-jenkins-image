FROM jenkins/jenkins:lts-jdk11

LABEL LATEST_UPDATE=February,1,2024

LABEL org.opencontainers.image.authors="miyamotoh@us.ibm.com,Sumangal.Mugalikar@ibm.com,rpsene@br.ibm.com"

USER root

RUN apt-get update && apt-get upgrade -y && apt-get install -y apt-transport-https \
    ca-certificates curl gnupg2 software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN apt-key fingerprint 0EBFCD88

RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"

RUN apt-get update && apt-get install -y docker-ce-cli

USER jenkins

#https://plugins.jenkins.io/blueocean/
RUN jenkins-plugin-cli --plugins blueocean:1.27.10

### This is a base Jenkins image used to manage PowerVS resources.
