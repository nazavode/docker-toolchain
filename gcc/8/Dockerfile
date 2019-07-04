FROM gcc:8
RUN apt update -y &&\
    apt -y upgrade &&\
    apt install -y git wget &&\
    wget -O ./install-cmake -q https://cmake.org/files/v3.10/cmake-3.10.3-Linux-x86_64.sh &&\
    chmod +x ./install-cmake &&\
    ./install-cmake --skip-license &&\
    rm -f ./install-cmake
