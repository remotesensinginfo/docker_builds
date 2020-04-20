FROM ubuntu:latest

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/miniconda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y apt-utils wget bzip2 ca-certificates curl git binutils vim libfftw3-dev gnuplot libgtk2.0-dev libgdal-dev libhdf5-dev libhdf5-100 libblas-dev libblas3 liblapack-dev liblapack3 liblapack-doc unzip make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/miniconda && \
    rm ~/miniconda.sh && \
    /opt/miniconda/bin/conda clean -tipsy && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Use python 3.7, update conda base and install AU-EOED software stack
RUN conda install --yes -c conda-forge python=3.7; sync && conda update --yes -n base conda; sync && \
    conda install --yes -c au-eoed -c conda-forge python=3.7 eodatadown arcsi rsgislib pb_process_tools sen1-ard-gamma compute-job-recorder scikit-learn scikit-image scikit-optimize scikit-plot scikit-fuzzy bayesian-optimization matplotlib pandas statsmodels h5py scipy rasterio shapely networkx sqlalchemy pycurl xgboost catboost lightgbm tpot seaborn ml_tooling cartopy numba pip sphinx elevation rtree luigi tqdm weasyprint jinja2; sync \
    && chmod +x /opt/miniconda/bin/*; sync \
    && conda clean --all -y; sync \
    && conda clean -tipsy && sync

RUN pip install pyod fiona geopandas schedule gsutil && sync

# set gdal and proj data paths
ENV GDAL_DATA=/opt/miniconda/share/gdal
ENV PROJ_LIB=/opt/miniconda/share/proj

RUN mkdir -p /opt/gamma
WORKDIR /opt/gamma
COPY GAMMA_SOFTWARE-20190613_MSP_ISP_DIFF_LAT.src.tar.gz /opt/gamma/GAMMA_SOFTWARE-20190613_MSP_ISP_DIFF_LAT.src.tar.gz
RUN cd /opt/gamma && tar -zxf /opt/gamma/GAMMA_SOFTWARE-20190613_MSP_ISP_DIFF_LAT.src.tar.gz \
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
    && cd $GAMMA_HOME/ISP/src; make -f makefile_static   \
    && sync

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]
