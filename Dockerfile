FROM kraxel/s2i-base-httpd

ENV SUMMARY="linux kerneldoc" \
    DESCRIPTION="Platform for building linux kernel documentation"

LABEL maintainer="Gerd Hoffmann <kraxel@redhat.com>" \
      summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      io.k8s.display-name="${SUMMARY}" \
      io.k8s.description="${DESCRIPTION}" \
      io.openshift.tags="linux,kerneldoc"

USER root

RUN source /etc/profile.d/proxy.sh; \
    dnf update -y && \
    dnf install -y make gcc gcc-c++ binutils bc \
                   glibc-devel openssl-devel \
                   graphviz which texlive-tetex \
                   python36 python3-pip && \
    dnf clean all -y

COPY ./s2i/bin/ /usr/libexec/s2i
COPY ./etc/*.conf /etc/httpd/conf.d/

RUN pip3 install sphinx sphinx-rtd-theme

USER 1001

CMD ["/usr/libexec/s2i/usage"]
