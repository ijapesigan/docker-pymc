FROM jupyter/scipy-notebook:python-3.11

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential graphviz \
 && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

RUN mamba install -y -n base -c conda-forge \
    "pymc>=5.15" \
    "jax>=0.4.30" "jaxlib>=0.4.30" \
    blackjax \
    arviz \
    statsmodels \
    graphviz \
 && mamba clean -afy

ENV PYTENSOR_FLAGS="cxx=/usr/bin/g++"

# extra metadata
LABEL org.opencontainers.image.source="https://github.com/ijapesigan/docker-pymc" \
      org.opencontainers.image.authors="Ivan Jacob Agaloos Pesigan <ijapesigan@gmail.com>"
