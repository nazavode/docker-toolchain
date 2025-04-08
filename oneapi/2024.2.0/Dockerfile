FROM gcc:13
LABEL org.opencontainers.image.source="https://github.com/nazavode/docker-toolchain"

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    git \
    wget \
    libblas-dev \
 # cmake
 && wget -O /tmp/install-cmake -q https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2-linux-x86_64.sh \
 && chmod +x /tmp/install-cmake \
 && /tmp/install-cmake --prefix=/usr --skip-license \
 # Download and install Intel OneAPI standalone compiler
 && wget --no-verbose --no-check-certificate -O /tmp/intel_dpcpp.sh https://registrationcenter-download.intel.com/akdlm/IRC_NAS/6780ac84-6256-4b59-a647-330eb65f32b6/l_dpcpp-cpp-compiler_p_2024.2.0.495_offline.sh \
 && echo "9463aa979314d2acc51472d414ffcee032e9869ca85ac6ff4c71d39500e5173d /tmp/intel_dpcpp.sh" > /tmp/checksum.txt \
 && sha256sum --check /tmp/checksum.txt \
 && sh /tmp/intel_dpcpp.sh -a --action install --components intel.oneapi.lin.dpcpp-cpp-compiler --silent --eula accept \
 # Needed just to allow boost to find OneAPI
 && . /opt/intel/oneapi/setvars.sh \
 # boost
 && mkdir -p /tmp/boost \
 && wget -q -O - https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz | tar xzf - -C /tmp/boost --strip-components 1 \
 && cd /tmp/boost \
 && ./bootstrap.sh --with-toolset=intel-linux --with-libraries=graph,program_options --prefix=/usr \
 && ./b2 cxxstd=17 toolset=intel-linux --with-graph --with-program_options stage \
 && ./b2 cxxstd=17 toolset=intel-linux --with-graph --with-program_options install \
 # Remove unneeded stuff
 && apt-get remove wget -y \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 # cleanup
 && rm -rf /tmp/* /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
