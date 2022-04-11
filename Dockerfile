# Container image that runs your code
FROM centos:centos7

LABEL "com.github.actions.name"="VM9 Version Bump"
LABEL "com.github.actions.description"="DevOps container to Bump versions"
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="purple"

LABEL version="1.0.0"
LABEL repository="https://github.com/we4city/version-bump-action"
LABEL homepage="https://vm9it.com/"
LABEL maintainer="Leonan Carvalho <j.leonancarvalho@gmail.com>"

# CentOS7, who doesn't love it?
RUN yum -y update  && \
    yum -y install epel-release

# Install git package
RUN yum -y remove git && yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm && \
    yum install -y git && \
    git --version
    
# Install JQ
RUN yum -y install jq
    
RUN yum clean all && \
    rm -rf /var/cache/yum

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
