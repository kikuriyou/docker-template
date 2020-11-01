FROM rapidsai/rapidsai:cuda10.2-runtime-ubuntu16.04

# Install basic dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    sudo git wget cmake htop pciutils nano vim tmux unzip curl snapd gcc g++ nodejs npm\
    build-essential ca-certificates software-properties-common && \
    npm install n -g && n stable && apt purge -y nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Configure environment
ENV CONDA_DIR=/opt/conda/envs/rapids 
ENV PATH=$CONDA_DIR/bin:$PATH

# Install jupyter-extension for plotly (-> swifter may not works)
RUN jupyter labextension install jupyterlab-plotly

RUN mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension
COPY ./themes.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension

# Install python packages
COPY ./requirements_conda.txt /tmp
RUN conda install -n rapids -f -y -q -c conda-forge --file /tmp/requirements_conda.txt && \
    conda clean --all -f -y

COPY ./requirements_pip.txt /tmp
RUN pip install -r /tmp/requirements_pip.txt

# Set working directory
WORKDIR /root/user/project

# config and clean up
RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove -y
