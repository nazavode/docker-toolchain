FROM buildpack-deps:stretch

RUN apt update &&\
    apt install -y --no-install-recommends \
        gnupg \
        dirmngr \
        wget
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN echo '\n\
deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch main\n\
deb-src http://apt.llvm.org/stretch/ llvm-toolchain-stretch main\n'\
  >> /etc/apt/sources.list
RUN apt update &&\
    apt install -y \
        clang-9 \
        lldb-9 \
        lld-9 \
        libc++-9-dev \
        libc++abi-9-dev \
        libomp-9-dev
RUN wget -O ./install-cmake -q https://cmake.org/files/v3.10/cmake-3.10.3-Linux-x86_64.sh &&\
    chmod +x ./install-cmake &&\
    ./install-cmake --skip-license
RUN rm -rf ./install-cmake /var/lib/apt/lists/*
ENV CC=clang-9    \
    CXX=clang++-9 \
    CXXFLAGS="-stdlib=libc++"
