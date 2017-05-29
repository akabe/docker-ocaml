FROM centos:7

ENV OPAM_VERSION  1.2.2
ENV OCAML_VERSION 4.02.3
ENV HOME          /home/opam

RUN yum update -y && \
    yum install -y sudo patch unzip make gcc libX11-devel && \
    yum clean all && \
    \
    adduser --home-dir $HOME --shell /bin/bash opam && \
    passwd -d opam && \
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
           $HOME/.opam/$OCAML_VERSION/build

USER opam
WORKDIR $HOME
ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "bash" ]
