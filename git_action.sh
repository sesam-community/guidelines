#!/bin/bash
## Deploys the master branch and any tags of a sesam-community or a contributer project to dockerhub.
## Requires following ENVVARS: GITHUB_REPO, GITHUB_BASE_REF, GITHUB_REF, GITHUB_SHA, GITHUB_RUN_NUMBER, DOCKER_USERNAME, DOCKER_PASSWORD

# make the build fail on any commands
set -v
set -e

_REPO="${GITHUB_REPO}"
_DEFAULT_REPO_NAME="${_REPO/#*\//}"
_REPO_NAME="${DOCKER_REPO_NAME:-$_DEFAULT_REPO_NAME}"

_DOCKER_REPO_TAG="development"
if  [ "${GITHUB_REF:0:10}" = "refs/tags/" ]
then
  _DOCKER_REPO_TAG="${GITHUB_REF:10}"
fi
echo "Docker image is set to'${DOCKER_USERNAME}/${_REPO_NAME}:${_DOCKER_REPO_TAG}'"


#build docker image
docker image build --label Commit="${GITHUB_SHA}" --label BuildNumber="${GITHUB_RUN_NUMBER}" --label RepoSlug="${_REPO}" -t ${_REPO_NAME}:${_DOCKER_REPO_TAG} .

#push to dockerhub if tagged or pushed to master
if  [ "${GITHUB_REF:0:10}" = "refs/tags/" ] || [ "${GITHUB_REF}" = "refs/heads/master" ]
then
  if [ -z "${DOCKER_USERNAME}" ]
  then
    echo "DOCKER_USERNAME is not set.Cannot push to docker registry"
    exit 1
  fi
  docker image tag ${_REPO_NAME}:${_DOCKER_REPO_TAG} ${DOCKER_USERNAME}/${_REPO_NAME}:${_DOCKER_REPO_TAG}
  docker image push ${DOCKER_USERNAME}/${_REPO_NAME}:${_DOCKER_REPO_TAG}
  docker logout
else
  echo "Skipping docker-push as per the logic"
fi
