ARG BASE_TAG
FROM frolvlad/alpine-glibc:$BASE_TAG

ARG OCAML_VERSION
ENV OPAM_VERSION  2.0.5
ENV OCAML_VERSION $OCAML_VERSION

# Install dependencies
RUN apk update && \
    apk add --upgrade --no-cache make patch gcc curl coreutils musl-dev

# Install OPAM
RUN curl -L -o /usr/bin/opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)" && \
    chmod 755 /usr/bin/opam

# OCaml
RUN opam init -a -y --comp $OCAML_VERSION --disable-sandboxing && \
    \
    find /root/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf /root/.opam/archives \
           /root/.opam/repo/default/archives \
           /root/.opam/$OCAML_VERSION/man \
           /root/.opam/$OCAML_VERSION/build

ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "/bin/sh" ]
