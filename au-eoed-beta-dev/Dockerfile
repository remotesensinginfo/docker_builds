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
RUN conda install --yes -c conda-forge python=3.9; sync && conda update --yes -n base conda; sync 
#RUN conda install --yes -c au-eoed -c conda-forge python=3.9 rsgislib pb_process_tools scikit-learn scikit-image scikit-optimize matplotlib pandas statsmodels h5py scipy rasterio shapely sqlalchemy pycurl  numba pip sphinx rtree tqdm parallel plotly psutil pyyaml; sync 
#RUN conda install --yes -c au-eoed -c conda-forge python=3.9 rsgislib pb_process_tools scikit-learn scikit-image scikit-optimize statsmodels matplotlib pandas h5py scipy rasterio shapely sqlalchemy pycurl numba  pip sphinx rtree parallel plotly psutil pyyaml psycopg2; sync 
RUN conda install --yes -c au-eoed -c conda-forge python=3.9 rsgislib pb_process_tools gdal=3.4 h5py scipy pip tqdm scikit-learn scikit-image sqlalchemy pycurl numba sphinx rtree pyyaml matplotlib pandas rtree 
RUN chmod +x /opt/miniconda/bin/*; sync \
    && conda clean --all -y; sync \
    && conda clean -tipsy && sync

#RUN pip install pyod fiona geopandas gsutil cvxopt dropbox  && sync
RUN pip install pyod geopandas xlsxwriter cvxopt gsutil feather-format openpyxl SALib alphashape && sync


# set gdal and proj data paths
ENV GDAL_DATA=/opt/miniconda/share/gdal
ENV PROJ_LIB=/opt/miniconda/share/proj

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD [ "/bin/bash" ]


