FROM ubuntu:22.04

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
       libblas-dev \
       liblapack-dev \
       make \
       numdiff \
       wget \
       ca-certificates \
       lsb-release \
       software-properties-common \
       gnupg2 \
 && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
 && echo "\
deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-18 main \n\
deb-src http://apt.llvm.org/jammy/ llvm-toolchain-jammy-18 main\n" >> /etc/apt/sources.list \
 && apt-get update -y \
 && apt-get install -y \
       clang-18 \
       clang-tools-18 \
       clang-format-18 \
       clang-tidy-18  \
       libclang-rt-18-dev \
       libc++-18-dev \
       libc++abi-18-dev \
       lld-18 \
       llvm-18-linker-tools \
 && ln -s /usr/bin/clang-18 /usr/bin/clang \
 && ln -s /usr/bin/clang++-18 /usr/bin/clang++ \
 && ln -s /usr/bin/lld-18 /usr/bin/lld \
 && ln -s /usr/bin/llvm-symbolizer-18 /usr/bin/llvm-symbolizer \
 && ln -s /usr/bin/clang-tidy-18 /usr/bin/clang-tidy \
 && ln -s /usr/bin/clang-format-18 /usr/bin/clang-format \
 # cmake
 && wget -O /tmp/install-cmake -q https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2-linux-x86_64.sh \
 && chmod +x /tmp/install-cmake \
 && /tmp/install-cmake --prefix=/usr --skip-license \
 # boost
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.86.0/source/boost_1_86_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=clang --with-libraries=graph,program_options --prefix=/usr \
 && ./b2 toolset=clang cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++" --with-graph --with-program_options stage \
 && ./b2 toolset=clang cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++" --with-graph --with-program_options install \
 # cleanup
 && rm -rf /tmp/* /var/lib/apt/lists/*
ENV CC=clang \
    CXX=clang++
