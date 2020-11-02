FROM petebunting/au-eoed

LABEL authors="Pete Bunting"
LABEL maintainer="petebunting@mac.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/miniconda/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive

RUN conda install -c conda-forge psycopg2

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

