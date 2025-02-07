FROM ubuntu:22.04
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        make \
        numdiff \
        llvm-15 \
        clang-15 \
        lld-15 \
        libc++-15-dev \
        libc++abi-15-dev \
        libblas-dev \
        liblapack-dev \
 && ln -s /usr/bin/clang-15 /usr/bin/clang \
 && ln -s /usr/bin/clang++-15 /usr/bin/clang++ \
 && ln -s /usr/bin/lld-15 /usr/bin/lld \
 && ln -s /usr/bin/llvm-symbolizer-15 /usr/bin/llvm-symbolizer \
 # cmake
 && wget -O /tmp/install-cmake -q https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2-linux-x86_64.sh \
 && chmod +x /tmp/install-cmake \
 && /tmp/install-cmake --prefix=/usr --skip-license \
 # boost
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.86.0/source/boost_1_86_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=clang --with-libraries=graph,program_options --prefix=/usr \
 && ./b2 cxxstd=17 toolset=clang cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++" --with-graph --with-program_options stage \
 && ./b2 cxxstd=17 toolset=clang cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++" --with-graph --with-program_options install \
 # cleanup
 && rm -rf /tmp/* /var/lib/apt/lists/*
ENV CC=clang \
    CXX=clang++
