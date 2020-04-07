# https://qiita.com/lain21/items/a33a39d465cd08b662f1

FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

# install basic dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    sudo git wget cmake nano vim gcc g++ build-essential ca-certificates software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# install python
RUN add-apt-repository ppa:deadsnakes/ppa \
&& apt-get update \
&& apt-get install -y python3.6 \
&& wget -O ./get-pip.py https://bootstrap.pypa.io/get-pip.py \
&& python3.6 ./get-pip.py \
&& ln -s /usr/bin/python3.6 /usr/local/bin/python3 \
&& ln -s /usr/bin/python3.6 /usr/local/bin/python

# install common python packages
RUN apt-get install -y libgomp1 \
&& apt-get install -y htop
ADD ./requirements.txt /tmp
RUN pip install pip setuptools -U && pip install -r /tmp/requirements.txt

# set working directory
WORKDIR /root/user/project

# config and clean up
RUN ldconfig \
&& apt-get clean \
&& apt-get autoremove