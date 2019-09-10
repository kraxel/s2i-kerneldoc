# kraxel/s2i-kerneldoc
FROM centos/httpd-24-centos7

LABEL maintainer="Gerd Hoffmann <kraxel@redhat.com>" \
      io.k8s.description="Platform for building linux kernel documentation" \
      io.k8s.display-name="linux kerneldoc" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="linux,kerneldoc"

USER root

RUN yum install -y make gcc gcc-c++ binutils bc \
                   glibc-devel openssl-devel \
                   python36 python36-libs python36-pip && \
    yum clean all -y

RUN for file in /usr/libexec/s2i/*; do cp -v $file ${file}.httpd; done
COPY ./s2i/bin/ /usr/libexec/s2i
COPY ./etc/scl_enable /etc/
COPY ./etc/kerneldoc-documentroot.conf /etc/httpd/conf.d/

ENV BASH_ENV="/etc/scl_enable"

RUN pip3 install sphinx

USER 1001
EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]
