FROM jenkins/jenkins:lts-jdk11

MAINTAINER Sumangal.Mugalikar@ibm.com

LABEL LATEST_UPDATE=November,18,2022

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
RUN jenkins-plugin-cli --plugins blueocean:1.25.8

### This is a base Jenkins image used to manage PowerVS resources.
