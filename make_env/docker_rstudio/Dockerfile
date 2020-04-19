# https://hub.docker.com/r/rocker/tidyverse/dockerfile
# https://blog.atusy.net/2019/04/16/littler-on-rocker/
# https://github.com/bquast/RDDtools

FROM rocker/tidyverse

# add basic dependencies
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    sudo git wget cmake htop pciutils nano vim curl snapd gcc g++ \
    ca-certificates software-properties-common \
    && apt-get install -y --reinstall build-essential \
    && rm -rf /var/lib/apt/lists/*

# add r-packages
RUN install2.r --ncpus -1 --skipinstalled --deps TRUE broom haven cobalt WeightIt MatchIt Matching doParallel caret
RUN install2.r --ncpus -1 --skipinstalled --deps TRUE miceadds CausalImpact
RUN Rscript -e "devtools::install_github('bquast/rddtools', dependencies = TRUE)"
RUN install2.r --ncpus -1 --skipinstalled --deps TRUE rdd
#RUN install2.r --ncpus -1 --skipinstalled --deps TRUE Ecdat 

# Set working directory
WORKDIR /home/rstudio/project

# config and clean up
RUN ldconfig \
&& apt-get clean \
&& apt-get autoremove