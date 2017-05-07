#!/bin/bash -eu

##
## dockerfile.sh
##
##   Usage: ./dockerfile.sh
##
##   Generate Dockerfile(s) for akabe/ocaml Docker images and publish them to github.com.
##

function print_dockerfile_header() {
    cat <<EOF
FROM ${BASE_IMAGE}

ENV OPAM_VERSION  ${OPAM}
ENV OCAML_VERSION ${OCAML}
ENV HOME          /home/opam

EOF
}

function print_dockerfile_footer() {
    cat <<'EOF' >>Dockerfile

USER opam
WORKDIR $HOME

ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "sh" ]
EOF
}

function print_dockerfile_alpine_script() {
    cat <<'EOF'
RUN apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache alpine-sdk libx11-dev && \
    mkdir /lib64 && \
    ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    adduser -h $HOME -s /bin/sh -D opam && \
    \
EOF
}

function print_dockerfile_common_script() {
    cat <<'EOF'
    echo 'opam ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers && \
    curl -s -L -o /usr/bin/opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)" && \
    chmod 755 /usr/bin/opam && \
    su opam -c "opam init -a -y --comp $OCAML_VERSION" && \
    rm $HOME/.profile $HOME/.opam/opam-init/init.* && \
    find $HOME/.opam -regex '.*\\.\\(cmt\\|cmti\\|annot\\|byte\\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/build
EOF
}

function print_dockerignore() {
    cat <<'EOF'
README.md
LICENSE
EOF
}

FIRST_COMMIT=41db134a4cc2a43c75746288848220ea09fe2194

ENVIRONMENTS=(
    'TAG=latest                BASE_IMAGE=alpine:3.5 OPAM=1.2.2 OCAML=4.04.1'
    'TAG=alpine3.5_ocaml4.06.0 BASE_IMAGE=alpine:3.5 OPAM=1.2.2 OCAML=4.06.0+trunk'
    'TAG=alpine3.5_ocaml4.05.0 BASE_IMAGE=alpine:3.5 OPAM=1.2.2 OCAML=4.05.0+trunk'
    'TAG=alpine3.5_ocaml4.04.1 BASE_IMAGE=alpine:3.5 OPAM=1.2.2 OCAML=4.04.1'
    'TAG=alpine3.5_ocaml4.03.0 BASE_IMAGE=alpine:3.5 OPAM=1.2.2 OCAML=4.03.0'
    'TAG=alpine3.5_ocaml4.02.3 BASE_IMAGE=alpine:3.5 OPAM=1.2.2 OCAML=4.02.3'
    'TAG=alpine3.5_ocaml4.01.0 BASE_IMAGE=alpine:3.5 OPAM=1.2.2 OCAML=4.01.0'
    'TAG=alpine3.5_ocaml4.00.1 BASE_IMAGE=alpine:3.5 OPAM=1.2.2 OCAML=4.00.1'
)

git checkout master

README="$(cat README.md)" # Capture README.md at master

for env_decl in "${ENVIRONMENTS[@]}"; do
    eval "$env_decl" # Expand variables
    BRANCH="release/${TAG}" # branch name

    # Checkout a branch
    if [[ -f ".git/refs/heads/$BRANCH" ]]; then
        git checkout $BRANCH
    else
        git checkout $FIRST_COMMIT -b $BRANCH
    fi

    # Create files
    echo "${README}" >README.md
    print_dockerignore >.dockerignore

    print_dockerfile_header        >Dockerfile
    if [[ "$BASE_IMAGE" =~ ^alpine: ]]; then
        print_dockerfile_alpine_script >>Dockerfile
    else
        echo "[Error] Unknown base image: $BASE_IMAGE"
        exit 1
    fi
    print_dockerfile_common_script >>Dockerfile
    print_dockerfile_footer        >>Dockerfile

    # Commit changes
    git add README.md .dockerignore Dockerfile
    if git commit -m 'updated distribution files'; then
        git push git@github.com:akabe/docker-ocaml.git $BRANCH
    fi
done
