FROM nvidia/cuda:latest

MAINTAINER Ole Algoritme
WORKDIR /

# ethminer dependencies
RUN apt-get update \
    && apt-get -y install software-properties-common \
    && add-apt-repository -y ppa:ethereum/ethereum -y \
    && apt-get update \
    && apt-get install -y git \
     cmake \
     libcryptopp-dev \
     libleveldb-dev \
     libjsoncpp-dev \
     libjsonrpccpp-dev \
     libboost-all-dev \
     libgmp-dev \
     libreadline-dev \
     libcurl4-gnutls-dev \
     ocl-icd-libopencl1 \
     opencl-headers \
     mesa-common-dev \
     libmicrohttpd-dev \
     build-essential

# clone ethminer git repo
RUN git clone https://github.com/ethereum-mining/ethminer.git; \
    cd ethminer; \

# build ethminer
RUN cd ethminer ; \
    mkdir build; cd build ; \
    cmake .. -DETHASHCUDA=ON -DETHASHCL=OFF -DETHSTRATUM=ON -DAPICORE=OFF -DBINKERN=OFF -DETHDBUS=ON -DUSE_SYS_OPENCL=ON ; \
    cmake --build . ; \
    make install;

# environment variables
ENV GPU_MAX_ALLOC_PERCENT=100
ENV GPU_SINGLE_ALLOC_PERCENT=100
ENV GPU_FORCE_64BIT_PTR=0
ENV GPU_MAX_HEAP_SIZE=100
ENV GPU_USE_SYNC_OBJECTS=1

ENTRYPOINT ["/usr/local/bin/ethminer", "-U"]
