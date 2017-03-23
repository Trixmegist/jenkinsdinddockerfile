FROM jenkins

ENV JENKINS_CI_DOCKER_BUILD_VERSION = 2

# Switch user to root so that we can install apps (jenkins image switches to user "jenkins" in the end)
USER root

# Install Docker prerequisites
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

# Install Docker
RUN apt-get update -qq && apt-get install -qqy docker-ce=17.03.0~ce-0~debian-jessie

# NodeJS + NPM
RUN	curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get install -y nodejs

# AWS-CLI
RUN apt-get install -qqy python python-setuptools python-dev build-essential && \
	easy_install pip && \
    pip --no-cache-dir install awscli
