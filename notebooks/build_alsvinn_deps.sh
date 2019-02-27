##### NOTE: We want to use MPICH, since it is the "native" supported MPI library for most clusters
##### (on Cray clusters they usually replace the mpich library with their own in the docker/shifter container)
##### Because of this, we need to compile some packages ourselves, even though they come with ubuntu
##### (but only with openmpi support)
export INSTALL_PREFIX=/userdata/klye/local_alsvinn


export PNETCDF_VERSION=1.10.0
export NETCDF_VERSION=4.6.1
export GTEST_VERSION=1.8.0

export BOOST_MAJOR_VERSION=1
export BOOST_MINOR_VERSION=68
export BOOST_RELEASE_VERSION=0

export CMAKE_MAJOR_VERSION=3
export CMAKE_MINOR_VERSION=12
export CMAKE_RELEASE_VERSION=2
export SCRATCH=/userdata/klye
set -e
##### CMAKE
cd $SCRATCH &&\
    wget https://cmake.org/files/v${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}/cmake-${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}.${CMAKE_RELEASE_VERSION}.tar.gz &&\
    tar xvf cmake-${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}.${CMAKE_RELEASE_VERSION}.tar.gz &&\
    cd cmake-${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}.${CMAKE_RELEASE_VERSION} && \
    ./bootstrap --system-curl --prefix=$INSTALL_PREFIX && \
    make && \
    make install && \
    cd $SCRATCH &&\
    rm -rf cmake*

##### HDF5
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.21/src/hdf5-1.8.21.tar.gz &&\
    tar xvf hdf5-1.8.21.tar.gz &&\
    cd hdf5-1.8.21 &&\
    ./configure --enable-parallel --prefix=$INSTALL_PREFIX &&\
    make &&\
    make install




##### NETCDF
export H5DIR=/usr/lib/mpich && \
    cd $SCRATCH && \
    wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-${NETCDF_VERSION}.tar.gz &&\
    tar xvf netcdf-${NETCDF_VERSION}.tar.gz && \
    cd netcdf-${NETCDF_VERSION} &&\
    export CPPFLAGS=-I${H5DIR}/include export CFLAGS=-L${H5DIR}/lib; \
    mkdir build;\
    cd build;\
    $INSTALL_PREFIX/bin/cmake .. -DCMAKE_C_COMPILER=`which mpicc` ~/local_alsvinn/bin/cmake .. -DCMAKE_PREFIX_PATH=/cluster/apps/szip/2.1/x86_64/gcc_4.8.2/ -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX && \
    make install &&\
    cd ../.. &&\
    rm -rf netcdf*

##### PNETCDF
cd ~ && \
    wget http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/parallel-netcdf-${PNETCDF_VERSION}.tar.gz &&\
    tar xvf parallel-netcdf-${PNETCDF_VERSION}.tar.gz &&\
    cd parallel-netcdf-${PNETCDF_VERSION} &&\
    export CFLAGS='-fPIC' &&\
    ./configure --prefix=$INSTALL_PREFIX &&\
    make install &&\
    cd $SCRATCH &&\
    rm -rf parallel-netcdf*

##### GTest
cd $SCRATCH &&\
    wget https://github.com/google/googletest/archive/release-${GTEST_VERSION}.zip &&\
    unzip release-${GTEST_VERSION}.zip &&\
    cd googletest-release-${GTEST_VERSION} &&\
    mkdir build &&\
    cd build &&\
    $INSTALL_PREFIX/bin/cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX -DCMAKE_C_COMPILER=`which $CC` -DCMAKE_CXX_COMPILER=`which $CXX`&&\
    make install &&\
    find . -iname '*.a' -exec cp {} ${INSTALL_PREFIX}/lib/ \; &&\
    cd $SCRATCH &&\
    rm -rf release-${GTEST_VERSION}.zip googletest-release-${GTEST_VERSION}





cd $SCRATCH &&\
    wget https://dl.bintray.com/boostorg/release/${BOOST_MAJOR_VERSION}.${BOOST_MINOR_VERSION}.${BOOST_RELEASE_VERSION}/source/boost_${BOOST_MAJOR_VERSION}_${BOOST_MINOR_VERSION}_${BOOST_RELEASE_VERSION}.tar.bz2 && \
    tar xvf boost_${BOOST_MAJOR_VERSION}_${BOOST_MINOR_VERSION}_${BOOST_RELEASE_VERSION}.tar.bz2 && cd boost_${BOOST_MAJOR_VERSION}_${BOOST_MINOR_VERSION}_${BOOST_RELEASE_VERSION} && \
    ./bootstrap.sh --with-python=`which python` --prefix=$INSTALL_PREFIX && \
    ./b2 --build-type=complete --layout=tagged install && \
    cd $SCRATCH && \
    rm -rf boost_*

