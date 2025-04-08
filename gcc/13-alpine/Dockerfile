FROM alpine:3.20
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

RUN apk add --no-cache \
          gcc \
          g++ \
          gfortran \
          git \
          wget \
          bzip2 \
          tar \
          unzip \
          file \
          patch \
          make \
          cmake \
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=gcc --with-libraries=graph,program_options --prefix=/usr \
 && ./b2 cxxstd=17 toolset=gcc link=static --with-graph --with-program_options stage \
 && ./b2 cxxstd=17 toolset=gcc link=static --with-graph --with-program_options install \
 && mkdir -p /tmp/openblas/build \
 && wget -q -O - https://github.com/OpenMathLib/OpenBLAS/archive/refs/tags/v0.3.27.tar.gz | tar xzf - -C /tmp/openblas --strip-components 1 \
 && cd /tmp/openblas/build \
 && cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_WITHOUT_LAPACK=ON -DDYNAMIC_ARCH=ON -DUSE_OPENMP=OFF -DBUILD_STATIC_LIBS=ON -DBUILD_TESTING=OFF .. \
 && make install \
 && rm -fr /tmp/*

ENV CC=gcc  \
    CXX=g++ \
    FC=gfortran
