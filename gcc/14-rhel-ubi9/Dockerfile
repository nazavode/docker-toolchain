FROM registry.access.redhat.com/ubi9/ubi:9.5-1736404036
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

RUN dnf -y install   \
      gcc-toolset-14 \
      git            \
      wget           \
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
 # openblas
 && mkdir -p /tmp/openblas/build \
 && wget -q -O - https://github.com/OpenMathLib/OpenBLAS/archive/refs/tags/v0.3.27.tar.gz | tar xzf - -C /tmp/openblas --strip-components 1 \
 && cd /tmp/openblas/build \
 && cmake -DCMAKE_INSTALL_PREFIX=/opt/rh/gcc-toolset-14/root/usr -DBUILD_WITHOUT_LAPACK=ON -DDYNAMIC_ARCH=ON -DUSE_OPENMP=OFF -DBUILD_STATIC_LIBS=ON -DBUILD_TESTING=OFF .. \
 && make install \
 # cleanup
 && dnf clean -y all \
 && rm -fr /tmp/*
