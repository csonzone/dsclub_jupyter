FROM ubuntu:16.04

FROM debian:latest 
#  $ docker build . -t continuumio/miniconda3:latest -t continuumio/miniconda3:4.5.4 
#  $ docker run --rm -it continuumio/miniconda3:latest /bin/bash 
#  $ docker push continuumio/miniconda3:latest 
#  $ docker push continuumio/miniconda3:4.5.4 

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 
ENV PATH /opt/conda/bin:$PATH 

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda

COPY environment.yml environment.yml
RUN conda env update -f environment.yml

#docker build -t csonzone/dsclub_jupyter .
#docker run -it csonzone/dsclub_jupyter /bin/bash


