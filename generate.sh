#!/bin/bash -eu

function opam_ocaml_scripts() {
    cat <<'EOF'
    echo 'opam ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers && \
    curl -L -o /usr/bin/opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)" && \
    chmod 755 /usr/bin/opam && \
    su opam -c "opam init -a -y --comp $OCAML_VERSION" && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build
EOF
}

function alpine_scripts() {
    cat <<EOF
RUN mkdir /lib64 && \\
    ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \\
    \\
    apk update && \\
    apk upgrade && \\
    apk add --upgrade --no-cache sudo make patch gcc curl musl-dev libx11 && \\
    apk add --upgrade --no-cache \\
            --virtual=.build-dependencies \\
            libx11-dev && \\
    \\
    adduser -h \$HOME -s /bin/sh -D opam && \\
    \\
$(opam_ocaml_scripts) && \\
    \\
    apk del .build-dependencies && \\
    ln -s /usr/lib/libX11.so.6 /usr/lib/libX11.so
EOF
}

function centos_scripts() {
    cat <<EOF
RUN yum update -y && \\
    yum install -y sudo patch unzip make gcc libX11-devel && \\
    yum clean all && \\
    \\
    adduser --home-dir \$HOME --shell /bin/bash opam && \\
    passwd -d opam && \\
    \\
$(opam_ocaml_scripts)
EOF
}

function debian_scripts() {
    cat <<EOF
RUN apt-get update && \\
    apt-get upgrade -y && \\
    apt-get install -y sudo patch unzip curl make gcc libx11-dev && \\
    \\
    adduser --disabled-password --home \$HOME --shell /bin/bash --gecos '' opam && \\
    \\
$(opam_ocaml_scripts) && \\
    \\
    apt-get autoremove -y && \\
    apt-get autoclean
EOF
}

echo "Generating dockerfiles/$TAG/Dockerfile (ALIAS=${ALIAS[@]})..."

mkdir -p dockerfiles/$TAG

cat <<EOF > dockerfiles/$TAG/Dockerfile
FROM ${OS}

ENV OPAM_VERSION  ${OPAM}
ENV OCAML_VERSION ${OCAML}
ENV HOME          /home/opam

EOF

if [[ "$OS" =~ ^alpine ]]; then
    alpine_scripts >> dockerfiles/$TAG/Dockerfile
    SHELL=sh
elif [[ "$OS" =~ ^centos: ]]; then
    centos_scripts >> dockerfiles/$TAG/Dockerfile
    SHELL=bash
elif [[ "$OS" =~ ^debian: ]]; then
    debian_scripts >> dockerfiles/$TAG/Dockerfile
    SHELL=bash
elif [[ "$OS" =~ ^ubuntu: ]]; then
    debian_scripts >> dockerfiles/$TAG/Dockerfile
    SHELL=bash
else
    echo -e "\033[31m[ERROR] Unknown base image: ${OS}\033[0m"
    exit 1
fi

cat <<EOF >> dockerfiles/$TAG/Dockerfile

USER opam
WORKDIR \$HOME
ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "${SHELL}" ]
EOF
