FROM ubuntu:22.04
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
       libblas-dev \
       make \
       wget \
       ca-certificates \
       lsb-release \
       software-properties-common \
       gnupg2 \
 && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
 && echo "\
deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main \n\
deb-src http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main\n" >> /etc/apt/sources.list \
 && apt-get update -y \
 && apt-get install -y \
       clang-17 \
       clang-tools-17 \
       clang-format-17 \
       clang-tidy-17  \
       libclang-rt-17-dev \
       libc++-17-dev \
       libc++abi-17-dev \
       lld-17 \
 && ln -s /usr/bin/clang-17 /usr/bin/clang \
 && ln -s /usr/bin/clang++-17 /usr/bin/clang++ \
 && ln -s /usr/bin/lld-17 /usr/bin/lld \
 && ln -s /usr/bin/llvm-symbolizer-17 /usr/bin/llvm-symbolizer \
 && ln -s /usr/bin/clang-tidy-17 /usr/bin/clang-tidy \
 && ln -s /usr/bin/clang-format-17 /usr/bin/clang-format \
 # cmake
 && wget -O /tmp/install-cmake -q https://github.com/Kitware/CMake/releases/download/v3.31.6/cmake-3.31.6-linux-x86_64.sh \
 && chmod +x /tmp/install-cmake \
 && /tmp/install-cmake --prefix=/usr --skip-license \
 # boost
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=clang --with-libraries=graph,program_options --prefix=/usr \
 && ./b2 cxxstd=17 toolset=clang cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++" --with-graph --with-program_options stage \
 && ./b2 cxxstd=17 toolset=clang cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++" --with-graph --with-program_options install \
 # cleanup
 && rm -rf /tmp/* /var/lib/apt/lists/*
ENV CC=clang \
    CXX=clang++
