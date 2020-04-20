#!/bin/bash -l

. /usr/share/modules/init/sh
. /home/spack/src/spack/share/spack/setup-env.sh

spack load python
spack load gdal
spack load sixs
spack load rsgislib
spack load postgresql
spack load hdf5
spack load qhull
spack load sqlite
spack load py-affine
spack load py-alabaster
spack load py-arcsi
spack load py-argparse
spack load py-asn1crypto
spack load py-attrs
spack load py-babel
spack load py-bokeh
spack load py-bottleneck
spack load py-cachetools
spack load py-certifi
spack load py-cftime
spack load py-chardet
spack load py-click
spack load py-click-plugins
spack load py-cligj
spack load py-cloudpickle
spack load py-compute-job-recorder
spack load py-cycler
spack load py-cython
spack load py-dask
spack load py-deap
spack load py-decorator
spack load py-docutils
spack load py-eodatadown
spack load py-et-xmlfile
spack load py-fiona
spack load py-flask
spack load py-geopandas
spack load py-gitdb
spack load py-gitpython
spack load py-google-auth
spack load py-google-cloud
spack load py-google-resumable-media-python
spack load py-h5py
spack load py-idna
spack load py-imagesize
spack load py-itsdangerous
spack load py-jdcal
spack load py-jinja2
spack load py-joblib
spack load py-jsonschema
spack load py-kiwisolver
spack load py-llvmlite
spack load py-locket
spack load py-markupsafe
spack load py-matplotlib
spack load py-ml-tooling
spack load py-munch
spack load py-netcdf4
spack load py-networkx
spack load py-nose
spack load py-numba
spack load py-numexpr
spack load py-numpy
spack load py-opendatacube
spack load py-openpyxl
spack load py-packaging
spack load py-pandas
spack load py-partd
spack load py-patsy
spack load py-pillow
spack load py-pkgconfig
spack load py-planet
spack load py-protobuf
spack load py-psycopg2
spack load py-py6s
spack load py-pyasn1
spack load py-pycurl
spack load py-pyepsg
spack load py-pygments
spack load py-pyod
spack load py-pyparsing
spack load py-pypeg2
spack load py-pyproj
spack load py-pysolar
spack load py-python-dateutil
spack load py-python-fmask
spack load py-pytz
spack load py-pywavelets
spack load py-pyyaml
spack load py-rasterio
spack load py-requests
spack load py-rios
spack load py-rsa
spack load py-scikit-image
spack load py-scikit-learn
spack load py-scipy
spack load py-seaborn
spack load py-setuptools
spack load py-setuptools-scm
spack load py-shapely
spack load py-six
spack load py-smmap
spack load py-snowballstemmer
spack load py-snuggs
spack load py-sphinx
spack load py-sphinx-rtd-theme
spack load py-sphinxcontrib-websupport
spack load py-sqlalchemy
spack load py-statsmodels
spack load py-stopit
spack load py-toolz
spack load py-tornado
spack load py-tpot
spack load py-tqdm
spack load py-urllib3
spack load py-vcversioner
spack load py-werkzeug
spack load py-xarray
spack load python

echo "#!/bin/bash -l" > /home/spack/entrypoint.sh
echo ". /home/spack/src/spack/share/spack/setup-env.sh" >> /home/spack/entrypoint.sh
echo "export PATH=$PATH" >> /home/spack/entrypoint.sh
echo "export PYTHONPATH=$PYTHONPATH" >> /home/spack/entrypoint.sh
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> /home/spack/entrypoint.sh
echo "export MANPATH=$MANPATH" >> /home/spack/entrypoint.sh
echo "export LIBRARY_PATH=$LIBRARY_PATH" >> /home/spack/entrypoint.sh
echo "export CPATH=$CPATH" >> /home/spack/entrypoint.sh
echo "export PKG_CONFIG_PATH=$PKG_CONFIG_PATH" >> /home/spack/entrypoint.sh
echo "export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH" >> /home/spack/entrypoint.sh
echo 'exec "$@"' >> /home/spack/entrypoint.sh
