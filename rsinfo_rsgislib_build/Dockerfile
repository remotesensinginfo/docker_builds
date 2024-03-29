FROM ubuntu:latest

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/miniconda/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update --fix-missing && \
    apt-get install -y apt-utils wget bzip2 ca-certificates curl git binutils vim make unzip cmake gcc g++ gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/miniconda && \
    rm ~/miniconda.sh && \
    /opt/miniconda/bin/conda clean --all -y && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Use python 3.11, update conda base and install AU-EOED software stack
RUN conda install --yes -c conda-forge python=3.11; sync \
    && conda update --yes -n base conda; sync \
    && conda install --yes mamba -n base -c conda-forge; sync
    
RUN mamba install --yes -c au-eoed -c conda-forge python=3.11 gdal geos gsl kealib xerces-c muparser boost-cpp rios scikit-learn scikit-image imbalanced-learn scikit-plot scikit-fuzzy bayesian-optimization optuna matplotlib pandas geopandas statsmodels h5py scipy rasterio shapely networkx sqlalchemy pycurl xgboost catboost lightgbm numba pip sphinx elevation rtree tqdm jinja2 keras parallel bokeh pygal jupyterlab psutil pysal libpysal esda pyyaml netcdf4 xarray rasterstats fiona plotly python-kaleido pyod psycopg2 contextily cvxopt feather-format openpyxl SALib xlsxwriter black flake8 pylint isort pytest pytest-html coverage pytest-cov requests imageio Pillow; sync \
    && chmod +x /opt/miniconda/bin/*; sync \
    && conda clean --all -y; sync 


RUN pip install gsutil alphashape pysptools matplotlib-scalebar pysondb BorutaShap fitz PyMuPDF mpl-scatter-density OWSLib && sync

# set gdal and proj data paths
ENV GDAL_DATA=/opt/miniconda/share/gdal
ENV PROJ_LIB=/opt/miniconda/share/proj

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]


