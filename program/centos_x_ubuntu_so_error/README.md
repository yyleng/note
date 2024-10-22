# ubuntu18.04 使用 centos7 下编译的库

## centos

```
docker run -it --rm -v `pwd`:/mnt centos:7.4.1708 bash

yum update -y
yum install -y centos-release-scl
yum install -y devtoolset-9 cmake
source /opt/rh/devtoolset-9/enable

gcc --version

mkdir build_centos && cd build_centos
cmake ..
make
./main
```

## ubuntu

```
docker run -it --rm -v `pwd`:/mnt ubuntu:18.04 bash

apt update -y
apt install -y build-essential

g++ -o main ../main.cpp -I .. -L ../build_centos/ -l shared

export LD_LIBRARY_PATH=$PWD/../build_centos/

./main
```
