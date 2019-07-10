FROM ubuntu:19.04

ARG INTEL_LLVM_GIT_REMOTE=https://github.com/intel/llvm
ARG INTEL_LLVM_GIT_BRANCH=sycl
ARG INTEL_LLVM_GIT_COMMIT=4bcb91e695869bc1f449eeb9f299c4daf8a9e8f7

ENV INTEL_LLVM_GIT_REMOTE=${INTEL_LLVM_GIT_REMOTE}
ENV INTEL_LLVM_GIT_BRANCH=${INTEL_LLVM_GIT_BRANCH}
ENV INTEL_LLVM_GIT_COMMIT=${INTEL_LLVM_GIT_COMMIT}

RUN apt -y update      &&\
    apt -y upgrade     &&\
    apt install -y       \
        apt-utils      &&\
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
RUN echo '\
e0ca356c474eda4a95a7d4d64b73e3f8d43b840f4d8c8a09b7c52b4cea7ecafc  intel-gmmlib_19.2.1_amd64.deb\n\
a5beeb99725428acc94e0c0659dc443f1a80ef8363cb70c5d69c1986c422bba1  intel-igc-core_1.0.9-2211_amd64.deb\n\
77bb334c8ebb55676941b06b3537b9571ef0c73a9757d0456b5da520c3de51c1  intel-igc-opencl_1.0.9-2211_amd64.deb\n\
a053b8c24315423aa006565030a662c25df5883fda45312bbeaf8f199a651b58  intel-ocloc_19.26.13286_amd64.deb\n\
8fcae0ebf7700896037d2d9416bfdb5c89a67edba51922c8fab94af71e8294fd  intel-opencl_19.26.13286_amd64.deb'                \
> checksums                                                                                                        &&\
    wget -q                                                                                                          \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-gmmlib_19.2.1_amd64.deb         \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-igc-core_1.0.9-2211_amd64.deb   \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-igc-opencl_1.0.9-2211_amd64.deb \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-opencl_19.26.13286_amd64.deb    \
        https://github.com/intel/compute-runtime/releases/download/19.26.13286/intel-ocloc_19.26.13286_amd64.deb   &&\
    sha256sum -c checksums                                                                                         &&\
    dpkg -i *.deb                                                                                                  &&\
    rm -fr /tmp/download
WORKDIR /opt/intel
RUN echo '\
5eb3c1b069e531d47d31b2381ab0d03ab6d4964f412fc39568bc713e6fc062b0  oclcpuexp.tar.gz'            \
> checksums                                                                                  &&\
    wget -q https://github.com/intel/llvm/releases/download/expoclcpu-1.0.0/oclcpuexp.tar.gz &&\
    sha256sum -c checksums                                                                   &&\
    tar zxvf oclcpuexp.tar.gz                                                                &&\
    echo /opt/intel/oclcpuexp/libintelocl.so > /etc/OpenCL/vendors/intel_expcpu.icd          &&\
    echo /opt/intel/oclcpuexp > /etc/ld.so.conf.d/libintelopenclexp.conf                     &&\
    ldconfig -f /etc/ld.so.conf.d/libintelopenclexp.conf                                     &&\
    rm -f oclcpuexp.tar.gz checksums
WORKDIR /src
RUN git clone --single-branch ${INTEL_LLVM_GIT_REMOTE} -b ${INTEL_LLVM_GIT_BRANCH} /src &&\
    git reset --hard ${INTEL_LLVM_GIT_COMMIT}                                           &&\
    mkdir -p build                                                                      &&\
    cd build                                                                            &&\
    cmake -DCMAKE_BUILD_TYPE=Release                                                      \
        -DLLVM_EXTERNAL_PROJECTS="llvm-spirv;sycl"                                        \
        -DLLVM_EXTERNAL_SYCL_SOURCE_DIR=/src/sycl                                         \
        -DLLVM_EXTERNAL_LLVM_SPIRV_SOURCE_DIR=/src/llvm-spirv                             \
        -DLLVM_ENABLE_PROJECTS="clang;llvm-spirv;sycl"                                    \
        /src/llvm                                                                       &&\
    make -j$(nproc) sycl-toolchain                                                      &&\
    # make -j$(nproc) check-all &&\  # tests are failing on sycl branch
    make -j$(nproc) install &&\
    rm -fr /src
WORKDIR /root
