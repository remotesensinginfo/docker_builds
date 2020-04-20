FROM ubuntu:latest

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/miniconda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y apt-utils wget bzip2 ca-certificates curl git binutils vim libfftw3-dev gnuplot libgtk2.0-dev gdal-bin gdal-data libgdal-dev python3-gdal libhdf5-dev libhdf5-100 libblas-dev libblas3 liblapack-dev liblapack3 liblapack-doc python3-numpy python3-scipy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir -p /opt/gamma
WORKDIR /opt/gamma
RUN wget https://www.dropbox.com/s/b3ezbl4gzf6cab1/GAMMA_SOFTWARE-20190613_MSP_ISP_DIFF_LAT.src.tar.gz \
    && tar -zxf GAMMA_SOFTWARE-20181130_MSP_ISP_DIFF_LAT.src.tar.gz \
    && rm /opt/gamma/GAMMA_SOFTWARE-20190613_MSP_ISP_DIFF_LAT.src.tar.gz 

ENV GAMMA_HOME=/opt/gamma/GAMMA_SOFTWARE-20190613
ENV MSP_HOME=$GAMMA_HOME/MSP \
    ISP_HOME=$GAMMA_HOME/ISP \
    DIFF_HOME=$GAMMA_HOME/DIFF \
    DISP_HOME=$GAMMA_HOME/DISP \
    LAT_HOME=$GAMMA_HOME/LAT

ENV PATH=$PATH:$MSP_HOME/bin:$ISP_HOME/bin:$DIFF_HOME/bin:$LAT_HOME/bin:$DISP_HOME/bin:$MSP_HOME/scripts:$ISP_HOME/scripts:$DIFF_HOME/scripts:$LAT_HOME/scripts:$DISP_HOME/scripts \
    HDF5_DISABLE_VERSION_CHECK=1 \
    GNUTERM=qt \
    GAMMA_RASTER="BMP" \
    OS=linux64

RUN cd $GAMMA_HOME/DISP/src; make -f makefile_static     \
    && cd $GAMMA_HOME/DIFF/src; make -f makefile_static  \
    && cd $GAMMA_HOME/ISP/src; make -f makefile_static   \
    && cd $GAMMA_HOME/LAT/src; make -f makefile_static   \
    && cd $GAMMA_HOME/ISP/src; make -f makefile_static

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]
