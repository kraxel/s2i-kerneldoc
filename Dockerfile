FROM centos:8

ENV SUMMARY="linux kerneldoc" \
    DESCRIPTION="Platform for building linux kernel documentation (centos7)"

LABEL maintainer="Gerd Hoffmann <kraxel@redhat.com>" \
      summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      io.k8s.display-name="${SUMMARY}" \
      io.k8s.description="${DESCRIPTION}" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="linux,kerneldoc" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

USER root

RUN dnf update -y;\
    dnf install -y make gcc gcc-c++ binutils bc \
                   glibc-devel openssl-devel \
                   graphviz which texlive-tetex \
                   python36 python3-pip && \
    dnf clean all -y

COPY ./s2i/bin/ /usr/libexec/s2i
COPY ./etc/kerneldoc-documentroot.conf /etc/httpd/conf.d/
RUN mkdir -p /opt/app-root;\
    chmod 755 /opt /opt/app-root;\
    useradd -d /opt/app-root/src -u 1001 default;\
    mkdir -p /run/httpd;\
    chmod 777 /run/httpd /etc/httpd/logs;\
    sed -i -e '/Listen/s/^/#/' /etc/httpd/conf/httpd.conf;\
    rm -f /etc/httpd/conf.d/welcome.conf

RUN pip3 install sphinx sphinx-rtd-theme

USER 1001
EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]
