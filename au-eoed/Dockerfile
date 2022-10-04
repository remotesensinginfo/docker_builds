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
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Use python 3.10, install mamba, update conda base
RUN conda install --yes -c conda-forge python=3.10; sync \
    && conda install --yes mamba -n base -c conda-forge; sync

# Removed alphashape and elevation as clashed with pycaret
# Install AU EOED software stack
RUN mamba install --yes -c conda-forge rsgislib arcsi gdal h5py parallel scikit-learn scikit-image scikit-optimize imbalanced-learn scikit-plot scikit-fuzzy bayesian-optimization matplotlib pandas geopandas statsmodels scipy rasterio shapely networkx sqlalchemy pycurl xgboost lightgbm catboost pycaret tensorflow tpot seaborn ml_tooling numba pip sphinx rtree tqdm jinja2 bokeh pygal jupyterlab psutil pysal libpysal esda pyyaml netcdf4 xarray fiona plotly psycopg2 ipywidgets contextily pydot cvxopt feather-format pyod xlsxwriter openpyxl SALib pymcr gsutil rasterstats pytables; sync \
    && chmod +x /opt/miniconda/bin/*; sync \
    && conda clean --all -y; sync

RUN pip install matplotlib_scalebar pysptools pysondb && sync

# Install pb_process_tools.
RUN cd /opt && \
    git clone https://github.com/remotesensinginfo/pb_process_tools.git && \
    cd pb_process_tools && \
    python setup.py install && \
    cd /opt && \
    rm -Rf ./pb_process_tools && \
    sync
    
# Install pysl4land.
RUN cd /opt && \
    git clone https://github.com/remotesensinginfo/pysl4land.git && \
    cd pysl4land && \
    python setup.py install && \
    cd /opt && \
    rm -Rf ./pysl4land && \
    sync

# set gdal and proj data paths
ENV GDAL_DATA=/opt/miniconda/share/gdal
ENV PROJ_LIB=/opt/miniconda/share/proj

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]


