#!/bin/bash -ue

function red_echo() {
    echo -e "\033[31m$@\033[0m"
}

function green_echo() {
    echo -e "\033[32m$@\033[0m"
}

function yellow_echo() {
    echo -e "\033[33m$@\033[0m"
}

function check_unpushed_changes() {
    source ./generate.sh # Update Dockerfile

    if git diff --name-only HEAD | grep "^dockerfiles/$TAG" >/dev/null; then
	red_echo "[ERROR] Changes for tag $TAG are not uncommited or unpushed."
	red_echo "        ./generate_all.sh and push the changes"
	git diff HEAD
	exit 127
    fi
}

## Print the difference of this pull request into STDOUT.
function git_diff_pullreq() {
    yellow_echo "Pull request: $TRAVIS_PULL_REQUEST" >&2

    if [[ "$TRAVIS_PULL_REQUEST" != false ]]; then
	curl -sL https://github.com/$TRAVIS_REPO_SLUG/pull/$TRAVIS_PULL_REQUEST.diff
    else
	local merge
	merge=$(git show | grep '^Merge: ' | awk '{print $2 ".." $3}')
	if [[ "$merge" == '' ]]; then
	    yellow_echo "The latest commit is not a merge." >&2
	    git show
	else
	    yellow_echo "The latest commit is a merge: $merge" >&2
	    git diff $merge
	fi
    fi
}

function build_image() {
    yellow_echo "[Build] $TAG: Dockerfile is changed."

    docker build -t akabe/ocaml:$TAG dockerfiles/$TAG
    docker history akabe/ocaml:$TAG
}

function test_image() {
    yellow_echo "[Test] $TAG"

    docker run --rm -v $PWD:$PWD -w $PWD/tests akabe/ocaml:$TAG sh run_test.sh
}

function deploy_image() {
    if [[ "$TRAVIS_PULL_REQUEST" == false ]] && [[ "$TRAVIS_BRANCH" == master ]]; then
	yellow_echo "[Deploy] Deploy image tag $TAG"

	docker login -u $DOCKER_USER -p $DOCKER_PWD
	docker push akabe/ocaml:$TAG

	for t in $ALIAS; do
	    yellow_echo "[Deploy] Deploy image tag $TAG as $t"
	    docker tag akabe/ocaml:$TAG akabe/ocaml:$t
	    docker push akabe/ocaml:$t
	done
    else
    	yellow_echo "[Deploy] Skip pushing image tag $TAG..."

    	for t in $ALIAS; do
    	    yellow_echo "[Deploy] Skip pushing image tag $t"
    	done
    fi
}

check_unpushed_changes

git_diff_pullreq > pullreq.diff
cat pullreq.diff

if grep "^+++ b/dockerfiles/$TAG/Dockerfile" pullreq.diff >/dev/null; then
    build_image
    test_image
    deploy_image
else
    green_echo "[ OK ] $TAG: Dockerfile is not changed."
fi
