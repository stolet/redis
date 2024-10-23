#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    echo "usage:"
    echo "[benchmark]"
    echo "benchmark=shim|linux"
    exit
fi

benchmark=$1

# Setup environment variables
export INSTALL_PREFIX=/local/mstolet
export WORKDIR=/local/mstolet
export HOME=/local/mstolet
export DEMIKERNEL_HOME=/local/mstolet
export LDFLAGS="-L/local/mstolet/lib:/local/mstolet/lib/x86_64-linux-gnu"
export CPPFLAGS="-I/local/mstolet/include:/local/mstolet/projects/papi/src/install/include"
export PKG_CONFIG_PATH=/local/mstolet/lib/x86_64-linux-gnu/pkgconfig
export CONFIG_PATH=$DEMIKERNEL_HOME/config.yaml
export LD_LIBRARY_PATH="/local/mstolet/lib:/local/mstolet/lib/x86_64-linux-gnu"
export LIBOS=catnip
redis_dir=$HOME/projects/redis
cd ${redis_dir}/src
pwd

if [ "$benchmark" == "shim" ]; then
    LD_PRELOAD=$HOME/lib/libshim.so ./redis-server ${redis_dir}/redis.conf
elif [ "$benchmark" == "linux" ]; then
    ./redis-server ${redis_dir}/redis.conf
else
    echo "Unrecognized benchmark type"
fi
