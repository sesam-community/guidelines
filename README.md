# How the Sesam Community works

This Github account is used to maintain and build reusable open source extensions for Sesam.

The Docker images are built and deployed to
 - https://hub.docker.com/r/sesamcommunity/ , when it is a sesam-community repo
or
 - https://hub.docker.com/r/[contributer]/ , when it is a contributers repo

## Requirements

- The extension require a LICENSE file that makes this process legal
- The extension should be usable from within Sesam
- The extension should be reusable
- The README file should contain an example

## Fork and build

All the extensions are ready up to be built with [Travis CI](http://travis-ci.org/).

You can contribute either
 - by forking an existing repo or
 - if it is a new repo, by contacting a community member to get your repo forked into sesam-community

Steps to build your own fork:
* Sign up at Dockerhub if you don't have an account
* prepare your repo & branch
* Sign up to Travis CI with your Github account
* Enable the forked repository inside Travis CI
* Add your DOCKER_USERNAME and DOCKER_PASSWORD as environment variables for the build inside Travis CI
* Travis CI will build and deploy once you _push_ to the master branch of your repository or create a release tag.
* Share your improvements using Pull Requests

## FAQ

##### Q: I want you to build and deploy my extension as well!
A: Just send an email to baard.johansen@sesam.io with a link to the repository and we'll sort it out!
