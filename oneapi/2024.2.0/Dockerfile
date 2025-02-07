FROM gcc:13
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    git \
    wget \
    numdiff \
    libblas-dev \
 # cmake
 && wget -O /tmp/install-cmake -q https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2-linux-x86_64.sh \
 && chmod +x /tmp/install-cmake \
 && /tmp/install-cmake --prefix=/usr --skip-license \
 # boost
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.86.0/source/boost_1_86_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=gcc --with-libraries=graph,program_options --prefix=/usr \
 && ./b2 toolset=gcc --with-graph --with-program_options stage \
 && ./b2 toolset=gcc --with-graph --with-program_options install \
 # Download and install Intel OneAPI standalone compiler
 && wget --no-verbose https://registrationcenter-download.intel.com/akdlm/IRC_NAS/6780ac84-6256-4b59-a647-330eb65f32b6/l_dpcpp-cpp-compiler_p_2024.2.0.495_offline.sh --no-check-certificate -O intel_dpcpp.sh \
 && sh ./intel_dpcpp.sh -a --action install --components intel.oneapi.lin.dpcpp-cpp-compiler --silent --eula accept \
 && rm -f ./intel_dpcpp.sh \
 # Remove unneeded stuff
 && apt-get remove wget -y \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 # cleanup
 && rm -rf /tmp/* /var/lib/apt/lists/*

ENV CC=icpc \
    CXX=icpx

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
