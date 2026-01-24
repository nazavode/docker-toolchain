FROM registry.access.redhat.com/ubi9/ubi:9.5-1736404036
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

COPY oneAPI.repo /etc/yum.repos.d/oneAPI.repo
RUN dnf -y update \
 && dnf -y install   \
      git            \
      wget           \
      glibc-static   \
      rpm-build      \
      gcc-toolset-14 \
      gcc-toolset-14-libasan-devel  \
      gcc-toolset-14-liblsan-devel  \
      gcc-toolset-14-libtsan-devel  \
      gcc-toolset-14-libubsan-devel \
      intel-oneapi-mkl-classic-devel-2025.3  \
 # cmake
 && wget -O /tmp/install-cmake -q https://github.com/Kitware/CMake/releases/download/v3.31.6/cmake-3.31.6-linux-x86_64.sh \
 && chmod +x /tmp/install-cmake \
 && /tmp/install-cmake --prefix=/opt/rh/gcc-toolset-14/root/usr --skip-license \
 # enable toolset
 && . /opt/rh/gcc-toolset-14/enable \
 # boost
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=gcc --with-libraries=graph,program_options --prefix=/opt/rh/gcc-toolset-14/root/usr \
 && ./b2 cxxstd=17 toolset=gcc link=static --with-graph --with-program_options stage \
 && ./b2 cxxstd=17 toolset=gcc link=static --with-graph --with-program_options install \
 # cleanup
 && dnf clean -y all \
 && rm -fr /tmp/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
