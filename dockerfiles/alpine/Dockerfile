ARG BASE_TAG
FROM frolvlad/alpine-glibc:$BASE_TAG

ARG OCAML_VERSION
ENV OPAM_VERSION  2.0.2
ENV OCAML_VERSION $OCAML_VERSION

# Install dependencies
RUN apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache sudo make patch gcc curl openssl musl-dev libx11

# Install OPAM
RUN curl -L -o /usr/bin/opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)" && \
    chmod 755 /usr/bin/opam

# Install OCaml with X11 Graphics module
RUN apk add --upgrade --no-cache \
            --virtual=.build-dependencies \
            libx11-dev && \
    \
    opam init -a -y --comp $OCAML_VERSION --disable-sandboxing && \
    \
    find /root/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf /root/.opam/archives \
           /root/.opam/repo/default/archives \
           /root/.opam/$OCAML_VERSION/man \
           /root/.opam/$OCAML_VERSION/build && \
    \
    apk del .build-dependencies && \
    ln -s /usr/lib/libX11.so.6 /usr/lib/libX11.so

ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "/bin/sh" ]
