FROM     ubuntu:18.04

LABEL    authors="Pete Bunting"
LABEL    maintainer="petebunting@mac.com"

ENV      LANG=C.UTF-8 LC_ALL=C.UTF-8 \
         DEBIAN_FRONTEND=noninteractive \
         HOME=/home/spack \
         SPACK_ROOT=/home/spack/src/spack \
         FORCE_UNSAFE_CONFIGURE=1


RUN      apt-get -yqq update --fix-missing                 \
      && apt-get -yqq install build-essential              \
                              ca-certificates              \
                              curl                         \
                              g++                          \
                              gcc                          \
                              gfortran                     \
                              git                          \
                              gnupg2                       \
                              make                         \
                              python                       \
                              unzip                        \
                              apt-utils                    \
                              autoconf                     \
                              bzip2                        \
                              vim                          \
                              mercurial                    \
                              sudo                         \
                              gzip                         \
                              tar                          \
                              wget                         \
                              binutils                     \
                              coreutils                    \
                              environment-modules          \
      && apt-get clean                                     \ 
      && rm -rf /var/lib/apt/lists/*                       \
      && ln -s /usr/bin/tclsh8.6 /usr/bin/tclsh


# Add non-privileged, but system docker user with sudo rights
RUN        groupadd -r spack -g 901 && \
           useradd -u 901 -r -m -g spack spack && \
           echo "spack ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/spack && \
           chmod 0440 /etc/sudoers.d/spack
# this is also the user that executes all commands below
USER       spack
WORKDIR    $HOME

COPY     packages.yaml .spack/packages.yaml
RUN      sudo chown spack:spack -R $HOME

# install spack
RUN   mkdir -p $HOME/src/spack \
      && git clone https://github.com/petebunting/spack.git $HOME/src/spack

ENV      PATH=$SPACK_ROOT/bin:$PATH

RUN spack install sqlite                        \
    && spack install openblas                   \
    && spack install python                     \
    && spack install cmake                      \
    && spack install py-numpy                   \
    && spack install boost                      \
    && spack install cgal                       \
    && spack install py-scipy                   \
    && spack install hdf5                       \
    && spack install kealib                     \
    && spack install gdal                       \
    && spack install py-h5py                    \
    && spack install py-chardet                 \
    && spack install py-urllib3                 \
    && spack install py-requests                \
    && spack install py-nose                    \
    && spack install py-matplotlib              \
    && spack install py-pandas                  \
    && spack install py-seaborn                 \
    && spack install py-rasterio                \
    && spack install py-networkx                \
    && spack install py-scikit-image            \
    && spack install py-scikit-learn            \
    && spack install py-tpot                    \
    && spack install py-ml-tooling              \
    && spack install py-pyod                    \
    && spack install py-xarray                  \
    && spack install py-statsmodels             \
    && spack install py-pycurl                  \
    && spack install py-sqlalchemy              \
    && spack install py-sphinx                  \
    && spack install py-bokeh                   \
    && spack install py-pyepsg                  \
    && spack install py-openpyxl                \
    && spack install py-psycopg2                \
    && spack install py-fiona                   \
    && spack install py-geopandas               \
    && spack install py-flask                   \
    && spack install py-numba                   \
    && spack install py-rios                    \
    && spack install py-python-fmask            \
    && spack install sixs                       \
    && spack install py-py6s                    \
    && spack install py-google-cloud            \
    && spack install py-planet                  \
    && spack install py-opendatacube            \
    && spack clean -a

RUN spack install rsgislib                      \
    && spack install py-arcsi                   \
    && spack install py-compute-job-recorder    \
    && spack install py-eodatadown              \
    && spack clean -a


# startup: force the use of a login shell
COPY genentrypoint.sh $HOME/genentrypoint.sh
RUN  /bin/bash $HOME/genentrypoint.sh 

USER root
RUN mv $HOME/entrypoint.sh /etc/entrypoint.sh \ 
    && chmod a+x /etc/entrypoint.sh
USER spack

ENTRYPOINT ["/etc/entrypoint.sh"]
CMD        ["/bin/bash"]

