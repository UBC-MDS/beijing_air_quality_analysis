# Docker file for the Beijing air quality project
# authors: Jacqueline Chong, Junrong Zhu, Macy Chan, Vadim Taskaev
# date: Dec 2021

# use rocker/tidyverse as the base image [Version: rocker/tidyverse:4]
FROM rocker/tidyverse@sha256:d0cd11790cc01deeb4b492fb1d4a4e0d5aa267b595fe686721cfc7c5e5e8a684

# install R packages using install.packages
RUN Rscript -e "install.packages('cowplot')" && \
    Rscript -e "install.packages('knitr')" && \
    Rscript -e "install.packages('docopt')" && \
    Rscript -e "install.packages('here')" && \
    Rscript -e "install.packages('testthat')"

# install the anaconda distribution of python
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy && \
    /opt/conda/bin/conda update -n base -c defaults conda

# put anaconda python in path
ENV PATH="/opt/conda/bin:${PATH}"

# install docopt python package
RUN conda install -y -c anaconda \ 
    docopt \
    requests \
    pandas 

