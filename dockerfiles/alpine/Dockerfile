ARG BASE_TAG
FROM frolvlad/alpine-glibc:$BASE_TAG

ARG OCAML_VERSION
ENV OPAM_VERSION  2.0.2
ENV OCAML_VERSION $OCAML_VERSION
ENV HOME          /home/opam

# Install dependencies
RUN apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache sudo make patch gcc curl openssl musl-dev libx11

# Install OPAM
RUN adduser -h $HOME -s /bin/sh -D opam && \
    echo 'opam ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers && \
    curl -L -o /usr/bin/opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)" && \
    chmod 755 /usr/bin/opam

# Install OCaml with X11 Graphics module
RUN apk add --upgrade --no-cache \
            --virtual=.build-dependencies \
            libx11-dev && \
    \
    su opam -c "opam init -a -y --comp $OCAML_VERSION --disable-sandboxing" && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    apk del .build-dependencies && \
    ln -s /usr/lib/libX11.so.6 /usr/lib/libX11.so

USER opam
WORKDIR $HOME
ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "/bin/sh" ]
