FROM ubuntu:latest

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/miniconda/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && \
    apt-get install -y apt-utils wget bzip2 ca-certificates curl git binutils vim make unzip apt-transport-https gnupg libfftw3-dev gnuplot libgtk2.0-dev libgdal-dev libhdf5-dev libblas-dev libblas3 liblapack-dev liblapack3 liblapack-doc make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /opt

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/miniconda && \
    rm ~/miniconda.sh && \
    /opt/miniconda/bin/conda clean -tipsy && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# use python 3.7 and update conda 
RUN conda install --yes -c conda-forge python=3.7 && conda update --yes -n base conda

# Install AU-EOED software stack
RUN conda install --yes -c conda-forge python=3.7 arcsi rsgislib scikit-learn scikit-image scikit-optimize scikit-plot scikit-fuzzy bayesian-optimization matplotlib pandas statsmodels h5py scipy rasterio shapely networkx sqlalchemy pycurl xgboost catboost lightgbm tpot seaborn ml_tooling cartopy numba pip sphinx elevation rtree tqdm jinja2 keras keras-preprocessing pytables parallel plotly bokeh pygal jupyterlab psutil weasyprint parallel pyyaml psycopg2 \
&& conda clean --yes -t

RUN pip install pyod fiona geopandas cvxopt dropbox google-cloud-storage google-cloud-bigquery alphashape

# set gdal and proj data paths
ENV GDAL_DATA=/opt/miniconda/share/gdal
ENV PROJ_LIB=/opt/miniconda/share/proj

# Install latest version of EODataDown
RUN mkdir -p /opt/eodatadown . && \
    cd /opt/eodatadown && \
    git clone https://github.com/remotesensinginfo/eodatadown.git . && \
    python ./setup.py install && \
    cd /opt && \
    rm -Rf ./eodatadown && \
    sync

# Install latest version of pb_process_tools
RUN mkdir -p /opt/pb_process_tools && \
    cd /opt/pb_process_tools && \
    git clone https://github.com/remotesensinginfo/pb_process_tools.git . && \
    python ./setup.py install && \
    cd /opt && \
    rm -Rf ./pb_process_tools && \
    sync
    
# Install latest version of sen1_ard_gamma
RUN mkdir -p /opt/sen1_ard_gamma && \
    cd /opt/sen1_ard_gamma && \
    git clone https://github.com/remotesensinginfo/sen1_ard_gamma.git . && \
    python ./setup.py install && \
    cd /opt && \
    rm -Rf ./sen1_ard_gamma && \
    sync

# Install Gamma Software
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


# Install google cloud tools
RUN mkdir -p /opt/google_cloud && \
    cd /opt/google_cloud && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-291.0.0-linux-x86_64.tar.gz && \
    tar -zxvf google-cloud-sdk-291.0.0-linux-x86_64.tar.gz google-cloud-sdk && \
    sh ./google-cloud-sdk/install.sh -q && \
    echo 'source /opt/google_cloud/google-cloud-sdk/completion.bash.inc' >> ~/.bashrc && \
    echo 'source /opt/google_cloud/google-cloud-sdk/path.bash.inc' >> ~/.bashrc && \
    sync

ENV PATH=$PATH:/opt/google_cloud/google-cloud-sdk/bin

WORKDIR /home

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]

