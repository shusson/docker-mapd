FROM ubuntu:16.04

MAINTAINER Shane Husson version: 0.1

RUN sed -i -- \
    's/# deb-src/deb-src/g' \
    /etc/apt/sources.list && \
    apt update && \
    apt install -y \
      autoconf \
      autoconf-archive \
      binutils-dev \
      bison++ \
      bisonc++ \
      build-essential \
      clang \
      clang-format \
      cmake \
      cmake-curses-gui \
      default-jdk \
      default-jdk-headless \
      default-jre \
      default-jre-headless \
      flex \
      git-core \
      golang \
      google-perftools \
      libboost-all-dev \
      libcurl4-openssl-dev \
      libdouble-conversion-dev \
      libevent-dev \
      libgdal-dev \
      libgflags-dev \
      libgoogle-glog-dev \
      libgoogle-perftools-dev \
      libiberty-dev \
      libjemalloc-dev \
      libldap2-dev \
      liblz4-dev \
      liblzma-dev \
      libncurses5-dev \
      libpng-dev \
      libsnappy-dev \
      libssl-dev \
      llvm \
      llvm-dev \
      maven \
      zlib1g-dev

WORKDIR /build

RUN apt build-dep -y thrift-compiler && \
    VERS=0.10.0 && \
    curl -O -L http://apache.claz.org/thrift/$VERS/thrift-$VERS.tar.gz && \
    tar xvf thrift-$VERS.tar.gz && \
    cd thrift-$VERS && \
    ./configure \
        --with-lua=no \
        --with-python=no \
        --with-php=no \
        --with-ruby=no \
        --prefix=/usr/local/mapd-deps && \
    make -j $(nproc) && \
    make install && \
    cd ..

RUN VERS=1.11.3 && \
    curl -O -L https://github.com/Blosc/c-blosc/archive/v$VERS.tar.gz && \
    tar xvf v$VERS.tar.gz && \
    BDIR="c-blosc-$VERS/build" && \
    rm -rf "$BDIR" && \
    mkdir -p "$BDIR" && \
    cd "$BDIR" && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr/local/mapd-deps \
        -DBUILD_BENCHMARKS=off \
        -DBUILD_TESTS=off \
        -DPREFER_EXTERNAL_SNAPPY=off \
        -DPREFER_EXTERNAL_ZLIB=off \
        -DPREFER_EXTERNAL_ZSTD=off \
        .. && \
    make -j $(nproc) && \
    make install && \
    cd ..


RUN VERS=2017.04.10.00 && \
    curl -O -L https://github.com/facebook/folly/archive/v$VERS.tar.gz && \
    tar xvf v$VERS.tar.gz && \
    cd folly-$VERS/folly && \
    /usr/bin/autoreconf -ivf && \
    ./configure --prefix=/usr/local/mapd-deps && \
    make -j $(nproc) && \
    make install && \
    cd ..

RUN VERS=1.21-45 && \
    curl -O -L https://github.com/jarro2783/bisonpp/archive/$VERS.tar.gz && \
    tar xvf $VERS.tar.gz && \
    cd bisonpp-$VERS && \
    ./configure && \
    make -j $(nproc) && \
    make install && \
    cd ..

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH=/usr/lib/jvm/default-java/jre/lib/amd64/server:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH=/usr/local/mapd-deps/lib:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH=/usr/local/mapd-deps/lib64:${LD_LIBRARY_PATH}
ENV PATH=/usr/local/cuda/bin:${PATH}
ENV PATH=/usr/local/mapd-deps/bin:${PATH}
ENV PATH=${PATH}:/build/mapd-core/build/bin

## 2dad055
## 21fc39 - stable

RUN cd /build && \
    git clone https://github.com/shusson/mapd-core.git && \
    cd mapd-core && \
    git checkout 6cfd99a && \
    mkdir -p /build/mapd-core/build && \
    cd /build/mapd-core/build && \
    cmake -DCMAKE_BUILD_TYPE=debug -DENABLE_CUDA=off .. && \
    make -j $(nproc)
