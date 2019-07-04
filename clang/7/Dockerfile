FROM buildpack-deps:stretch

RUN apt update &&\
    apt install -y --no-install-recommends \
        gnupg \
        dirmngr \
        wget
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN echo '\n\
deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch-7 main\n\
deb-src http://apt.llvm.org/stretch/ llvm-toolchain-stretch-7 main\n'\
  >> /etc/apt/sources.list
RUN apt update &&\
    apt install -y \
        clang-7 \
        lldb-7 \
        lld-7 \
        libc++-7-dev \
        libc++abi-7-dev \
        libomp-7-dev
RUN wget -O ./install-cmake -q https://cmake.org/files/v3.10/cmake-3.10.3-Linux-x86_64.sh &&\
    chmod +x ./install-cmake &&\
    ./install-cmake --skip-license
RUN rm -rf ./install-cmake /var/lib/apt/lists/*
ENV CC=clang-7    \
    CXX=clang++-7 \
    CXXFLAGS="-stdlib=libc++"
