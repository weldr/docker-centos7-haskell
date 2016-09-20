# A CentOS7 Stack image using upstream repo
FROM centos:7
MAINTAINER Brian C. Lane <bcl@redhat.com>
RUN cd /tmp && curl -sSL https://downloads.haskell.org/~platform/7.10.3/haskell-platform-7.10.3-unknown-posix-x86_64.tar.gz | tar -xz && ./install-haskell-platform.sh

RUN yum -y install sudo curl file gnu-c++ gcc gdb glibc-devel openssl-devel gmp-devel make zlib-devel xz-devel

# Upstream puts ghci, etc. into /usr/local/bin
RUN echo 'PATH=/usr/local/bin/:$PATH' >> /etc/bashrc

# Switch to user specified by LOCAL_USERNAME LOCAL_UID env variables
# Depends on bash, useradd, and sudo
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
