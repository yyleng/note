#====== c++ debug lib ======
```sh
cd ../tools
auto-extract dbg-macro-master.zip 
cd dbg-macro-master
sudo cp dbg.h /usr/include/dbg.h
#site:https://github.com/sharkdp/dbg-macro
```

#====== hash function ======
```sh
unsigned long hash(unsigned char *str) {
  unsigned long hash = 5381;
  int c;
  while (c = *str++)
    hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
  return hash;
}
```

#====== memory leak check ======
```sh
valgrind --leak-check=full ELF
```

#====== grpc install and config (c++) ======
```sh
sudo yum install build-essential autoconf libtool pkg-config
git clone https://github.com/grpc/grpc.git
cd grpc 
git submodule update --init
mkdir build 
cd build 
cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF ..
make 
sudo make install 
vim ~/.zshrc
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib
source ~/.zshrc
# test example
cd examples/cpp/helloworld
make greeter_server
make greeter_client
```

#===== *.a *.so =====
ar -crv libitemsaico.a items.o
g++ -fpic 
g++ --shared
