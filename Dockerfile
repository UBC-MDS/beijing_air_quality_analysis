# Docker file for the Beijing air quality project
# authors: Jacqueline Chong, Junrong Zhu, Macy Chan, Vadim Taskaev
# date: Dec 2021

# use rocker/tidyverse as the base image [Version: rocker/tidyverse:4]
FROM rocker/tidyverse@sha256:d0cd11790cc01deeb4b492fb1d4a4e0d5aa267b595fe686721cfc7c5e5e8a684

# check the base image is updated
RUN apt-get update --fix-missing

#install necessary R packages
RUN apt-get update -qq && apt-get --no-install-recommends install \
  && install2.r --error \
  --deps TRUE \
  here \
  knitr \
  infer \
  docopt \
  kableExtra

# install R packages using install.packages
RUN Rscript -e "install.packages('cowplot')" && \
    Rscript -e "install.packages('testthat')" && \
    Rscript -e "install.packages('infer')" && \
    Rscript -e "install.packages('ggthemes')" && \
    Rscript -e "install.packages('caret')"

# add a missing apt package to save images
RUN apt-get install -y --no-install-recommends libxt6

# install miniconda3 python distribution
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

# create python path
ENV PATH="/root/miniconda3/bin:${PATH}"

# add conda-forge channel
RUN conda config --append channels conda-forge


# install python packages
RUN conda install -y -c anaconda \
    docopt=0.6.* \
    pandas=1.3.* \
    requests

#install pandoc correctly
RUN conda install -c conda-forge pandoc=2.16.*
