ARG BASE_TAG
FROM centos:$BASE_TAG

ARG OCAML_VERSION
ENV OPAM_VERSION  2.0.2
ENV OCAML_VERSION $OCAML_VERSION

# Install dependencies
RUN yum update -y && \
    yum install -y sudo patch unzip make gcc libX11-devel && \
    yum clean all

# Install OPAM
RUN curl -L -o /usr/bin/opam "https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)" && \
    chmod 755 /usr/bin/opam

# Install OCaml with X11 Graphics module
RUN opam init -a -y --comp $OCAML_VERSION --disable-sandboxing && \
    \
    find /root/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf /root/.opam/archives \
           /root/.opam/repo/default/archives \
           /root/.opam/$OCAML_VERSION/man \
           /root/.opam/$OCAML_VERSION/build

ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "/bin/bash" ]
