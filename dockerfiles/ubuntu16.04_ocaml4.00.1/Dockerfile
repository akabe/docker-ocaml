FROM ubuntu:16.04

ENV OPAM_VERSION  1.2.2
ENV OCAML_VERSION 4.00.1
ENV HOME          /home/opam

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo patch unzip curl make gcc libx11-dev && \
    \
    adduser --disabled-password --home $HOME --shell /bin/bash --gecos '' opam && \
    \
    echo 'opam ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers && \
    curl -L -o /usr/bin/opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)" && \
    chmod 755 /usr/bin/opam && \
    su opam -c "opam init -a -y --comp $OCAML_VERSION" && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    apt-get autoremove -y && \
    apt-get autoclean

USER opam
WORKDIR $HOME
ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "bash" ]
