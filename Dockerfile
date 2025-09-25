FROM python:3.11-slim

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential graphviz tini \
 && rm -rf /var/lib/apt/lists/*

# Python dependencies
RUN pip install -U uv && \
    uv pip install --system \
      jupyterlab \
      "pymc>=5.15" "jax[cpu]>=0.4.30" "jaxlib>=0.4.30" \
      blackjax arviz statsmodels graphviz \
      python-lsp-server  # optional: nicer editor experience

# Make PyTensor use g++
ENV PYTENSOR_FLAGS="cxx=/usr/bin/g++"

# Create a non-root user and a writable work dir
ARG NB_USER=jovyan
ARG NB_UID=1000
RUN useradd -m -s /bin/bash -u $NB_UID $NB_USER
WORKDIR /home/$NB_USER/work
USER $NB_USER

# Jupyter config
# Empty token is okay on a trusted machine; set a token in `docker run` for security.
ENV JUPYTER_TOKEN=""
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD jupyter lab --ip=0.0.0.0 --no-browser --ServerApp.token= --IdentityProvider.token=


# extra metadata
LABEL org.opencontainers.image.source="https://github.com/ijapesigan/docker-pymc" \
      org.opencontainers.image.authors="Ivan Jacob Agaloos Pesigan <ijapesigan@gmail.com>"
