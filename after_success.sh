#!/bin/bash
## Deploys the master branch and any tags of a sesam-community or a contributer project to dockerhub.
# make the build fail on any commands
set -v
set -e
SLUG="$TRAVIS_REPO_SLUG"
REPO_NAME="${SLUG/#*\//}"
GIT_REPO_OWNER="${SLUG/%\/*/}"

#add similar line as below for each contributer that has GIT_REPO_OWVER and DOCKER_REPO_OWNER different
DOCKER_REPO_OWNER=${GIT_REPO_OWNER/sesam-community/sesamcommunity}


if [ "$TRAVIS_BRANCH" == "master" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]
then
  DOCKER_REPO_TAG="latest"
elif [ -n "$TRAVIS_TAG" ]
then
  DOCKER_REPO_TAG="$TRAVIS_TAG"
fi

if [ -n "$DOCKER_REPO_TAG" ]
then
  docker build -t $DOCKER_REPO_OWNER/$REPO_NAME:$DOCKER_REPO_TAG .
  docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
  docker push $DOCKER_REPO_OWNER/$REPO_NAME:$DOCKER_REPO_TAG
fi
