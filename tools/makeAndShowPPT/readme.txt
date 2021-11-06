require:
    yum install -y ncurses-devel

install:
    mkdir build
    cd build
    cmake ..
    make
    make install 
    yum install -y 
