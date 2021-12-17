FROM petebunting/rsinfo_rsgislib_build

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

WORKDIR /opt

RUN mkdir -p /opt/rsgislib_bld && \
    cd /opt/rsgislib_bld && \
    git clone https://github.com/remotesensinginfo/rsgislib.git && \
    cd rsgislib && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/opt/miniconda -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_SKIP_RPATH=OFF -DGDAL_INCLUDE_DIR=/opt/miniconda/include -DGDAL_LIB_PATH=/opt/miniconda/lib -DBOOST_INCLUDE_DIR=/opt/miniconda/include -DBOOST_LIB_PATH=/opt/miniconda/lib -DGSL_INCLUDE_DIR=/opt/miniconda/include -DGSL_LIB_PATH=/opt/miniconda/lib -DMUPARSER_INCLUDE_DIR=/opt/miniconda/include -DMUPARSER_LIB_PATH=/opt/miniconda/lib -DHDF5_INCLUDE_DIR=/opt/miniconda/include -DHDF5_LIB_PATH=/opt/miniconda/lib -DKEA_INCLUDE_DIR=/opt/miniconda/include -DKEA_LIB_PATH=/opt/miniconda/lib .. && \
    make -j 4 && \
    make install && \
    cd /opt && \
    rm -Rf rsgislib_bld && \
    sync

# Install latest version of pb_process_tools
RUN mkdir -p /opt/pb_process_tools && \
    cd /opt/pb_process_tools && \
    git clone https://github.com/remotesensinginfo/pb_process_tools.git . && \
    python ./setup.py install && \
    cd /opt && \
    rm -Rf ./pb_process_tools && \
    sync
    

RUN pip install psycopg2
 




