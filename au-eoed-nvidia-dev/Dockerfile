FROM nvcr.io/nvidia/cuda:10.1-runtime-ubuntu18.04

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/miniconda/bin:$PATH

COPY nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
#COPY cuda-repo-ubuntu1804_10.1.243-1_amd64.deb cuda-repo-ubuntu1804_10.1.243-1_amd64.deb

RUN apt-get update --fix-missing && \
    apt-get install -y apt-utils wget bzip2 ca-certificates curl git binutils vim make gnupg gnupg1 gnupg2 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub && \
    apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends libcudnn7=7.6.4.38-1+cuda10.1 libcudnn7-dev=7.6.4.38-1+cuda10.1 && \
    apt-get install -y --no-install-recommends libnvinfer6=6.0.1-1+cuda10.1 libnvinfer-dev=6.0.1-1+cuda10.1 libnvinfer-plugin6=6.0.1-1+cuda10.1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb 

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/miniconda && \
    rm ~/miniconda.sh && \
    /opt/miniconda/bin/conda clean -tipsy && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Use python 3.7, update conda base and install AU-EOED software stack
RUN conda install --yes -c conda-forge python=3.7; sync && conda update --yes -n base conda; sync && \
    conda install --yes -c au-eoed -c conda-forge python=3.7 rsgislib pb_process_tools scikit-learn scikit-image scikit-optimize scikit-plot scikit-fuzzy bayesian-optimization matplotlib pandas statsmodels h5py scipy rasterio shapely networkx sqlalchemy pycurl xgboost catboost lightgbm tpot seaborn ml_tooling cartopy numba pip sphinx rtree tqdm jinja2 pytables plotly bokeh pygal jupyterlab; sync \
    && chmod +x /opt/miniconda/bin/*; sync \
    && conda clean --all -y; sync \
    && conda clean -tipsy && sync

RUN pip install pyod fiona geopandas gsutil cvxopt tensorflow torch torchvision neptune-client && sync

# set gdal and proj data paths
ENV GDAL_DATA=/opt/miniconda/share/gdal
ENV PROJ_LIB=/opt/miniconda/share/proj

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]



