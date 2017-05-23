#!/bin/bash
## Deploys the master branch and any tags of a sesam-community project to dockerhub.
# make the build fail on any commands
set -v
set -e
SLUG="$TRAVIS_REPO_SLUG"
REPO_NAME=${SLUG#sesam-community/}
if [ "$TRAVIS_BRANCH" == "master" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]
then
  docker build -t sesamcommunity/$REPO_NAME .
  docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
  docker push sesamcommunity/$REPO_NAME:latest
fi
if [ -n "$TRAVIS_TAG" ]
then
  docker build -t sesamcommunity/$REPO_NAME .
  docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
  docker push sesamcommunity/$REPO_NAME:$TRAVIS_TAG
fi
