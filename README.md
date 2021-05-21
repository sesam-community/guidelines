# How the Sesam Community works

This Github account is used to maintain and build reusable open source extensions for Sesam.

The Docker images are built and deployed to
 - https://hub.docker.com/r/sesamcommunity/ , when it is a sesam-community repo
or
 - https://hub.docker.com/r/[contributer]/ , when it is a contributers repo

## Requirements

- The extension require a LICENSE file that makes this process legal. Apache License 2.0 is the preferred one.
- The extension should be usable from within Sesam
- The extension should be reusable
- The README file should contain an example
- CI&CD should be setup as described below

## How to contribute

You can contribute either
 - by forking an existing repo from the community github or
 - by contacting a community member to get your repo created in sesam-community so that the proper setup is granted.

Steps to build your own fork:
* Sign up at Dockerhub if you don't have an account
* Prepare your repo & branch
* Set up CI&CD as described below
* Share your improvements using Pull Requests

### How to set up CI&CD

_For repo without a CI/CD setup, keep reading. Otherwise, if _travis_ is already in action, jump to section "how to migrate from travis-ci to github-actions?"_

CI consists of building a docker image with the updates.

CD consists of pushing a docker image with the updates. pushes to 'master' branch publishes 'development' image tag while releases publish image with the release tag.

With GithubActions (preferred)
  1. Make sure DOCKER_USERNAME and DOCKER_PASSWORD secrets are available to the repo at repo settings->secrets or organization settings->secrets. To push the image to an organization namespace on docker hub -that DOCKER_USERNAME has access to-, define also DOCKER_ORGNAME secret.
  2. Make sure the Dockerfile if in the top folder of the repository. That is what the action code expects.
  3. Add 'Sesam Community CI&CD Workflow' action.
     1. If sesam-community repo, go to Actions and click "Set up this workflow"
     2. If private repo, do either of followings:
        - fork [this] (https://github.com/sesam-community/.github) and add the action via github
        - execute this on your local machine inside the repo ```mkdir -p .github/workflows/ && curl -s "https://raw.githubusercontent.com/sesam-community/.github/master/workflow-templates/sesam-community-ci-cd.yml" > .github/workflows/sesam-community-ci-cd.yml```
     4. if docker repo owner and github repo owner are not literally identical, uncomment and set DOCKER_REPO_NAME in the action code
     5. commit

With Travis(Deprecated)
 * Sign up to Travis CI with your Github account
 * Enable the forked repository inside Travis CI
 * Add your DOCKER_USERNAME and DOCKER_PASSWORD as environment variables for the build inside Travis CI
 * Travis CI will build and deploy once you create a new release tag in your repository.

#### How to migrate from travis-ci to github-actions?
  1. delete `.travis.yml` file
  2. Setup CI&CD with GithubActions as described above
  3. add new status badge to README. Delete status badge for travis-ci, if any.
     - if _md_ file: Replace `GITHUB_REPO_NAME` below and add ```[![SesamCommunity CI&CD](https://github.com/sesam-community/<GITHUB_REPO_NAME>/actions/workflows/sesam-community-ci-cd.yml/badge.svg)](https://github.com/sesam-community/<GITHUB_REPO_NAME>/actions/workflows/sesam-community-ci-cd.yml) ```
     - if _rst_ file: Replace `GITHUB_REPO_NAME` below and add ```.. image:: https://github.com/sesam-community/<GITHUB_REPO_NAME>/actions/workflows/sesam-community-ci-cd.yml/badge.svg
   :target: https://github.com/sesam-community/<GITHUB_REPO_NAME>/actions/workflows/sesam-community-ci-cd.yml```


## FAQ

##### Q: I want you to build and deploy my extension as well!
A: Just send an email to baard.johansen@sesam.io with a link to the repository and we'll sort it out!
