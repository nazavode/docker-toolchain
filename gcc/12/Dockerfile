FROM gcc:12
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    git \
    wget \
    numdiff \
    libblas-dev \
    liblapack-dev \
 # cmake
 && wget -O /tmp/install-cmake -q https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2-linux-x86_64.sh \
 && chmod +x /tmp/install-cmake \
 && /tmp/install-cmake --prefix=/usr --skip-license \
 # boost
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.86.0/source/boost_1_86_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=gcc --with-libraries=graph,program_options --prefix=/usr \
 && ./b2 cxxstd=17 toolset=gcc --with-graph --with-program_options stage \
 && ./b2 cxxstd=17 toolset=gcc --with-graph --with-program_options install \
 # cleanup
 && rm -rf /tmp/* /var/lib/apt/lists/*
ENV CC=gcc  \
    CXX=g++ \
    FC=gfortran
