FROM registry.access.redhat.com/ubi9/ubi:9.5-1736404036
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

COPY oneAPI.repo /etc/yum.repos.d/oneAPI.repo
RUN dnf -y install   \
      gcc-toolset-14 \
      git            \
      wget           \
      rpm-build      \
      intel-oneapi-dpcpp-cpp-2024.2 \
      intel-oneapi-mkl-devel-2024.0-2024.0.0-49656 \
 # cmake
 && wget -O /tmp/install-cmake -q https://github.com/Kitware/CMake/releases/download/v3.31.6/cmake-3.31.6-linux-x86_64.sh \
 && chmod +x /tmp/install-cmake \
 && /tmp/install-cmake --prefix=/opt/rh/gcc-toolset-14/root/usr --skip-license \
 # enable toolset
 && . /opt/rh/gcc-toolset-14/enable \
 # enable OneAPI
 && . /opt/intel/oneapi/setvars.sh \
 # boost
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=intel-linux --with-libraries=graph,program_options --prefix=/opt/rh/gcc-toolset-14/root/usr \
 && ./b2 cxxstd=17 toolset=intel-linux link=static --with-graph --with-program_options stage \
 && ./b2 cxxstd=17 toolset=intel-linux link=static --with-graph --with-program_options install \
 # cleanup
 && dnf clean -y all \
 && rm -fr /tmp/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
