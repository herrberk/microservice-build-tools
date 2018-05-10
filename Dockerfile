FROM ubuntu:18.04

ENV GCC_VERSION gcc-8
ENV GPP_VERSION g++-8
ENV CMAKE_VERSION 3.11
ENV CMAKE_SUBVERSION 3.11.1
ENV CMAKE_TEMP_DIR cmake-temp

#install wget
RUN apt-get update && apt-get install -y wget && \
    #install gcc, gpp
    apt-get install ${GCC_VERSION} ${GPP_VERSION} -y && \
    #install make
    apt-get install make -y && \
    #install cmake
    mkdir ${CMAKE_TEMP_DIR} && cd ${CMAKE_TEMP_DIR} && \
    wget --quiet https://cmake.org/files/v${CMAKE_VERSION}/cmake-${CMAKE_SUBVERSION}-Linux-x86_64.tar.gz && \
    tar -xzvf cmake-${CMAKE_SUBVERSION}-Linux-x86_64.tar.gz && \
    cd cmake-${CMAKE_SUBVERSION}-Linux-x86_64 && \
    cp -r bin /usr/ && cp -r share /usr/ && cp -r doc /usr/share/ && cp -r man /usr/share/ && \
    cd ../.. && rm -r ${CMAKE_TEMP_DIR} && \
    #update gcc, gpp 
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/${GPP_VERSION} 100 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/${GCC_VERSION} 100

CMD ["echo", "Contains the required build tools for C++ Microservice."]