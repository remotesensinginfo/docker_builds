FROM nvidia/cuda:12.0.0-runtime-ubuntu20.04

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/miniconda/bin:$PATH

COPY nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb

RUN apt-get update --fix-missing && \
    apt-get install -y apt-utils wget bzip2 ca-certificates curl git binutils vim make gnupg gnupg1 gnupg2 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub && \
    apt install ./nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb && \
    apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb 
    
#apt-get install -y --no-install-recommends libcudnn7=7.6.4.38-1+cuda10.1 libcudnn7-dev=7.6.4.38-1+cuda10.1 && \
#apt-get install -y --no-install-recommends libnvinfer6=6.0.1-1+cuda10.1 libnvinfer-dev=6.0.1-1+cuda10.1 libnvinfer-plugin6=6.0.1-1+cuda10.1 && \

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/miniconda && \
    rm ~/miniconda.sh && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Use python 3.10, install mamba, update conda base
RUN conda install --yes -c conda-forge python=3.10; sync \
    && conda install --yes mamba -n base -c conda-forge; sync

RUN mamba install --yes -c conda-forge rsgislib gdal h5py parallel scikit-learn scikit-image scikit-optimize imbalanced-learn scikit-plot scikit-fuzzy bayesian-optimization matplotlib pandas geopandas statsmodels scipy rasterio shapely networkx sqlalchemy pycurl py-xgboost-gpu catboost pytorch-gpu torchvision tpot seaborn ml_tooling numba pip sphinx rtree tqdm jinja2 bokeh pygal jupyterlab psutil pysal libpysal esda pyyaml netcdf4 xarray fiona plotly psycopg2 ipywidgets contextily pydot cvxopt feather-format pyod xlsxwriter openpyxl SALib pymcr gsutil rasterstats pytables; sync \
    && chmod +x /opt/miniconda/bin/*; sync \
    && conda clean --all -y; sync


RUN pip install matplotlib_scalebar pysptools pysondb tensorflow; sync
# && \
#   pip install lightgbm --install-option=--gpu; sync

# Install pb_process_tools.
RUN cd /opt && \
    git clone https://github.com/remotesensinginfo/pb_process_tools.git && \
    cd pb_process_tools && \
    python setup.py install && \
    cd /opt && \
    rm -Rf ./pb_process_tools && \
    sync


# set gdal and proj data paths
ENV GDAL_DATA=/opt/miniconda/share/gdal
ENV PROJ_LIB=/opt/miniconda/share/proj

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]



