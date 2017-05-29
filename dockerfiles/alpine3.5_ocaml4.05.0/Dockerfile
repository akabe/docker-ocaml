FROM alpine:3.5

ENV OPAM_VERSION  1.2.2
ENV OCAML_VERSION 4.05.0+trunk
ENV HOME          /home/opam

RUN mkdir /lib64 && \
    ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    \
    apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache sudo curl make patch gcc musl-dev libx11 && \
    apk add --upgrade --no-cache \
            --virtual=.build-dependencies \
            libx11-dev && \
    \
    adduser -h $HOME -s /bin/sh -D opam && \
    \
    echo 'opam ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers && \
    curl -L -o /usr/bin/opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)" && \
    chmod 755 /usr/bin/opam && \
    su opam -c "opam init -a -y --comp $OCAML_VERSION" && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/compilers \
           $HOME/.opam/repo/default/packages \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    apk del .build-dependencies && \
    ln -s /usr/lib/libX11.so.6 /usr/lib/libX11.so

USER opam
WORKDIR $HOME
ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "sh" ]
