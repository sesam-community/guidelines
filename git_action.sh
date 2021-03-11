#!/bin/bash
## Deploys the master branch and any tags of a sesam-community or a contributer project to dockerhub.
## Requires following ENVVARS: GITHUB_REPO, GITHUB_BASE_REF, GITHUB_REF, GITHUB_SHA, GITHUB_RUN_NUMBER, DOCKER_USERNAME
## Supports  optional ENVVARS: DOCKER_REPO_NAME, DOCKER_ORGNAME

# make the build fail on any commands
set -v
set -e

_REPO="${GITHUB_REPO}"
_DEFAULT_REPO_NAME="${_REPO/#*\//}"
_REPO_NAME="${DOCKER_REPO_NAME:-$_DEFAULT_REPO_NAME}"
_DOCKER_ID="${DOCKER_ORGNAME:-$DOCKER_USERNAME}"

_DOCKER_REPO_TAG="development"
if  [ "${GITHUB_REF:0:10}" = "refs/tags/" ]
then
  _DOCKER_REPO_TAG="${GITHUB_REF:10}"
fi
echo "Docker image is set to'${_DOCKER_ID}/${_REPO_NAME}:${_DOCKER_REPO_TAG}'"


#build docker image
docker build --label Commit="${GITHUB_SHA}" --label BuildNumber="${GITHUB_RUN_NUMBER}" --label RepoSlug="${_REPO}" -t ${_REPO_NAME}:${_DOCKER_REPO_TAG} .

#push to dockerhub if tagged or pushed to master
if  [ "${GITHUB_REF:0:10}" = "refs/tags/" ] || [ "${GITHUB_REF}" = "refs/heads/master" ]
then
  if [ -z "${_DOCKER_ID}" ]
  then
    echo "Neither DOCKER_ORGNAME nor DOCKER_USERNAME is set.Cannot push to docker registry!"
    exit 1
  fi
  docker tag ${_REPO_NAME}:${_DOCKER_REPO_TAG} ${_DOCKER_ID}/${_REPO_NAME}:${_DOCKER_REPO_TAG}
  docker push ${_DOCKER_ID}/${_REPO_NAME}:${_DOCKER_REPO_TAG}
  docker logout
else
  echo "Skipping docker-push as per the logic"
fi
