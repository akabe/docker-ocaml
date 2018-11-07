ARG BASE_IMAGE
ARG BASE_TAG
FROM $BASE_IMAGE:$BASE_TAG

ARG OCAML_VERSION
ENV OPAM_VERSION  1.2.2
ENV OCAML_VERSION $OCAML_VERSION
ENV HOME          /home/opam

# Install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo patch unzip curl make gcc libx11-dev

# Install OPAM
RUN adduser --disabled-password --home $HOME --shell /bin/bash --gecos '' opam && \
    echo 'opam ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers && \
    curl -L -o /usr/bin/opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)" && \
    chmod 755 /usr/bin/opam

# Install OCaml with X11 Graphics module
RUN su opam -c "opam init -a -y --comp $OCAML_VERSION" && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build

USER opam
WORKDIR $HOME
ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "/bin/bash" ]
