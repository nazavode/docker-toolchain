FROM centos:centos7.6.1810
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

ENV LANG="en_US.UTF-8"
ENV LC_CTYPE="en_US.UTF-8"
ENV LC_NUMERIC="en_US.UTF-8"
ENV LC_TIME="en_US.UTF-8"
ENV LC_COLLATE="en_US.UTF-8"
ENV LC_MONETARY="en_US.UTF-8"
ENV LC_MESSAGES="en_US.UTF-8"
ENV LC_ALL=

# Starting from 1st July 2024 this version of centos
# is EOL, change all URLs to vault repos
COPY CentOS-Base.repo /etc/yum.repos.d/
RUN yum -y install centos-release-scl
RUN sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
RUN sed -i s/^\#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
RUN sed -i s/^mirrorlist=http/\#mirrorlist=http/g /etc/yum.repos.d/*.repo
RUN yum -y clean all
RUN yum -y update

RUN yum -y install      \
      devtoolset-9      \
      python3           \
      git               \
      wget              \
      bzip2             \
      tar               \
      unzip             \
      file              \
      patch             \
      atlas-devel       \
      blas-devel        \
      devtoolset-9-libubsan-devel \
      devtoolset-9-libasan-devel  \
      devtoolset-9-liblsan-devel  \
      devtoolset-9-libtsan-devel  \
 # cmake
 && wget -O /tmp/install-cmake -q https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2-linux-x86_64.sh \
 && chmod +x /tmp/install-cmake \
 && /tmp/install-cmake --prefix=/usr --skip-license \
 # enable devtoolset
 && . /opt/rh/devtoolset-9/enable \
 # boost - dynamic
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.86.0/source/boost_1_86_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=gcc --with-libraries=graph,program_options --prefix=/opt/rh/devtoolset-9/root/usr \
 && ./b2 cxxstd=17 toolset=gcc --with-graph --with-program_options stage \
 && ./b2 cxxstd=17 toolset=gcc --with-graph --with-program_options install \
 # openblas
 && mkdir -p /tmp/openblas \
 && wget -q -O - https://github.com/OpenMathLib/OpenBLAS/archive/refs/tags/v0.3.27.tar.gz | tar xzf - -C /tmp/openblas --strip-components 1 \
 && cd /tmp/openblas \
 && make \
 && make install PREFIX=/opt/rh/devtoolset-9/root/usr \
 # cleanup
 && yum clean all \
 && rm -fr /var/cache/yum \
 && rm -fr /tmp/*

# Make sure devtoolset-9 is always enabled:
ENV PATH="/opt/rh/devtoolset-9/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    MANPATH="/opt/rh/devtoolset-9/root/usr/share/man:" \
    INFOPATH="/opt/rh/devtoolset-9/root/usr/share/info" \
    PCP_DIR="/opt/rh/devtoolset-9/root" \
    LD_LIBRARY_PATH="/opt/rh/devtoolset-9/root/usr/lib64:/opt/rh/devtoolset-9/root/usr/lib:/opt/rh/devtoolset-9/root/usr/lib64/dyninst:/opt/rh/devtoolset-9/root/usr/lib/dyninst:/opt/rh/devtoolset-9/root/usr/lib64:/opt/rh/devtoolset-9/root/usr/lib" \
    PKG_CONFIG_PATH="/opt/rh/devtoolset-9/root/usr/lib64/pkgconfig" \
    CC=gcc  \
    CXX=g++ \
    FC=gfortran
