FROM centos:7

ENV OPAM_VERSION  1.2.2
ENV OCAML_VERSION 4.00.1
ENV HOME          /home/opam

RUN yum update -y && \
    yum install -y sudo patch unzip make libx11 \
                   libx11-devel gcc && \
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
    find $HOME/.opam -regex '.*\\.\\(cmt\\|cmti\\|annot\\|byte\\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    yum remove -y libx11-devel

USER opam
WORKDIR $HOME
ENTRYPOINT [ "opam", "config", "exec", "--" ]
CMD [ "bash" ]
