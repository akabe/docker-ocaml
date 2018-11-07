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
    yellow_echo "[Build] Files under $DIRECTORY is changed."

    docker build --rm \
           --build-arg BASE_IMAGE=$BASE_IMAGE \
           --build-arg BASE_TAG=$BASE_TAG \
           --build-arg OCAML_VERSION=$OCAML \
           -t akabe/ocaml:fresh \
           "$DIRECTORY"
    docker history akabe/ocaml:fresh
}

function test_image() {
    yellow_echo "[Test] OCaml version $OCAML on $BASE"

    docker run --rm -v $PWD:$PWD -w $PWD/tests akabe/ocaml:fresh sh run_test.sh
}

function deploy_image() {
    if [[ "$TRAVIS_PULL_REQUEST" == false ]] && [[ "$TRAVIS_BRANCH" == master ]]; then
	docker login -u $DOCKER_USER -p $DOCKER_PWD

	for t in ${TAGS[@]}; do
	    yellow_echo "[Deploy] Deploy image tag $t"
	    docker tag akabe/ocaml:fresh akabe/ocaml:$t
	    docker push akabe/ocaml:$t
	done
    else
    	yellow_echo "[Deploy] Skip pushing an image."
    fi
}

BASE_IMAGE="$(echo $BASE | grep -o '^[^:]*')"
BASE_TAG="$(echo $BASE | grep -o '[^:]*$')"
DIRECTORY=''

if [ "$BASE_IMAGE" == alpine ]; then
    DIRECTORY=dockerfiles/alpine
elif [ "$BASE_IMAGE" == centos ]; then
    DIRECTORY=dockerfiles/centos
elif [ "$BASE_IMAGE" == debian ]; then
    DIRECTORY=dockerfiles/debian
else
    red_echo "[Error] Unknown base image $BASE"
fi

git_diff_pullreq > pullreq.diff
cat pullreq.diff

if grep "^+++ b/$DIRECTORY" pullreq.diff >/dev/null; then
    build_image
    test_image
    deploy_image
else
    green_echo "[ OK ] Files under $DIRECTORY is not changed."
fi
