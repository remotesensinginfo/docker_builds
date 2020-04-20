FROM ubuntu:latest

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/miniconda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y apt-utils wget bzip2 ca-certificates curl git binutils vim make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/miniconda && \
    rm ~/miniconda.sh && \
    /opt/miniconda/bin/conda clean -tipsy && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# use python 3.8 and update conda 
RUN conda install --yes -c conda-forge python=3.8 && conda update --yes -n base conda

# Install AU-EOED software stack
RUN conda install --yes -c conda-forge python=3.8 arcsi rsgislib scikit-learn scikit-image scikit-optimize scikit-plot scikit-fuzzy bayesian-optimization matplotlib pandas statsmodels h5py scipy rasterio shapely rasterio networkx sqlalchemy pycurl xgboost catboost lightgbm tpot seaborn ml_tooling cartopy numba pip sphinx elevation rtree tqdm jinja2 keras keras-preprocessing pytables parallel plotly bokeh pygal jupyterlab psutil weasyprint \
&& conda clean --yes -t

RUN pip install pyod fiona geopandas gsutil cvxopt dropbox

# set gdal and proj data paths
ENV GDAL_DATA=/opt/miniconda/share/gdal
ENV PROJ_LIB=/opt/miniconda/share/proj

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]

