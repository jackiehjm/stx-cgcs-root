# Expected build arguments:
#   RELEASE: centos release
#   REPO_OPTS: yum options to enable StarlingX repo
#
ARG RELEASE=7.5.1804
FROM centos:${RELEASE}

ARG REPO_OPTS

# The stx.repo file must be generated by the build tool first
COPY stx.repo /

RUN set -ex ;\
    sed -i '/\[main\]/ atimeout=120' /etc/yum.conf ;\
    mv /stx.repo /etc/yum.repos.d/ ;\
    yum upgrade --disablerepo=* ${REPO_OPTS} -y ;\
    yum install --disablerepo=* ${REPO_OPTS} -y \
        qemu-img \
        openssh-clients \
        ;\
    rm -rf \
        /var/log/* \
        /tmp/* \
        /var/tmp/*
