# Makefile
#
# AUTHOR: Josh Thies
#
# USAGE:
#   make login release
#
# NOTE: This checks that you are git status clean before doing a release
#
# REFERENCES:
#   This Makefile was based on:
#   - https://blog.container-solutions.com/tagging-docker-images-the-right-way
#
# TODO: Investigate using Jenkins instead for staged releases

MK_AT  := @
 
DOCKER_USER   := breakdownlane
DOCKER_REPO   := qsharp

NAME   := ${DOCKER_USER}/${DOCKER_REPO}
# Make a tag based on the git version so that there is an intuitive, recoverable mapping
TAG    := $(shell git log -1 --pretty=%H)
IMG    := ${NAME}:${TAG}
# Also move the needle on latest
LATEST := ${NAME}:latest
 
# Only do a build if I am git status clean
build:
	${MK_AT}git status --short | grep --quiet --no-messages --perl-regexp '.*' || \
	docker build -t ${IMG} . && \
	docker tag ${IMG} ${LATEST}
 
push:
	${MK_AT}docker push ${NAME}
 
# This requires setting up docker-credential-pass or other and setting up gpg
# REFERENCE:
#   Setting up pass:
#   - https://medium.com/@chasinglogic/the-definitive-guide-to-password-store-c337a8f023a1
login:
	${MK_AT}docker login

release: build push
