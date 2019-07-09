FROM ubuntu:19.04

ENV INTEL_LLVM_GIT_REMOTE=https://github.com/intel/llvm \
    INTEL_LLVM_GIT_BRANCH=sycl                          \
    INTEL_LLVM_GIT_COMMIT=2b585ff0e4c8fb94cc8ac8ea6241502abbc38eb8

RUN apt -y update      &&\
    apt -y upgrade     &&\
    apt install -y       \
        pkg-config       \
        git              \
        wget             \
        build-essential  \
        python-dev       \
        python-psutil    \
        cmake            \
        spirv-tools    &&\
    rm -fr /var/lib/apt/lists/*
WORKDIR /tmp/download
RUN wget -q \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-gmmlib_19.2.1_amd64.deb         \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-igc-core_1.0.9-2211_amd64.deb   \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-igc-opencl_1.0.9-2211_amd64.deb \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-opencl_19.26.13286_amd64.deb    \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-ocloc_19.26.13286_amd64.deb     \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/ww26.sum                            &&\
    sha256sum -c ww26.sum &&\
    dpkg -i *.deb         &&\
    rm -fr /tmp/download
WORKDIR /opt/intel
RUN wget -q https://github.com/intel/llvm/releases/download/expoclcpu-1.0.0/oclcpuexp.tar.gz &&\
    tar zxvf oclcpuexp.tar.gz                                                                &&\
    echo /opt/intel/oclcpuexp/libintelocl.so > /etc/OpenCL/vendors/intel_expcpu.icd          &&\
    echo /opt/intel/oclcpuexp > /etc/ld.so.conf.d/libintelopenclexp.conf                     &&\
    ldconfig -f /etc/ld.so.conf.d/libintelopenclexp.conf                                     &&\
    rm -f oclcpuexp.tar.gz
WORKDIR /src
RUN git clone --depth=1 --single-branch ${INTEL_LLVM_GIT_REMOTE} -b ${INTEL_LLVM_GIT_BRANCH} /src &&\
    mkdir -p build &&\
    cd build &&\
    cmake -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_EXTERNAL_PROJECTS="llvm-spirv;sycl" \
        -DLLVM_EXTERNAL_SYCL_SOURCE_DIR=/src/sycl \
        -DLLVM_EXTERNAL_LLVM_SPIRV_SOURCE_DIR=/src/llvm-spirv \
        -DLLVM_ENABLE_PROJECTS="clang;llvm-spirv;sycl" \
        /src/llvm &&\
    make -j$(nproc) sycl-toolchain &&\
    make -j$(nproc) check-all &&\
    make -j$(nproc) install &&\
    rm -fr /src
ENV CC=clang-9    \
    CXX=clang++-9 \
    CXXFLAGS="-stdlib=libc++"
WORKDIR $HOME
