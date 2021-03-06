FROM ubuntu:latest

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/miniconda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y apt-utils wget bzip2 ca-certificates curl git binutils vim make unzip && \
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
    conda install --yes -c au-eoed -c conda-forge python=3.7 eodatadown arcsi rsgislib pb_process_tools sen1-ard-gamma pysl4land compute-job-recorder scikit-learn=0.23.1 scikit-image scikit-optimize scikit-plot scikit-fuzzy bayesian-optimization matplotlib pandas statsmodels h5py scipy rasterio shapely networkx sqlalchemy pycurl xgboost catboost lightgbm tpot seaborn ml_tooling cartopy numba pip sphinx elevation rtree luigi tqdm weasyprint jinja2 keras keras-preprocessing pytables parallel plotly bokeh pygal jupyterlab psutil pysal libpysal esda pyyaml netcdf4 xarray rasterstats; sync \
    && chmod +x /opt/miniconda/bin/*; sync \
    && conda clean --all -y; sync \
    && conda clean -tipsy && sync

#RUN pip install pyod fiona geopandas gsutil cvxopt dropbox  && sync
RUN pip install pyod cvxopt gsutil feather-format openpyxl SALib alphashape && sync

# Install Open Data Cube.
#RUN cd /opt && \
#    wget https://github.com/opendatacube/datacube-core/archive/datacube-1.7.tar.gz && \
#    tar -zxf datacube-1.7.tar.gz && \
#    cd datacube-core-datacube-1.7 && \
#    python setup.py install && \
#    cd /opt && \
#    rm -Rf ./datacube* && \
#    sync

# set gdal and proj data paths
ENV GDAL_DATA=/opt/miniconda/share/gdal
ENV PROJ_LIB=/opt/miniconda/share/proj

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]


