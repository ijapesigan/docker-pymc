FROM condaforge/mambaforge:latest

WORKDIR /app

# Create environment with PyMC
RUN mamba create -y -n pymc_env -c conda-forge "pymc>=5" && \
    mamba run -n pymc_env conda install -y numpyro blackjax -c conda-forge && \
    mamba run -n pymc_env conda install -y nutpie -c conda-forge && \
    mamba clean -afy

# Register kernel for Jupyter
RUN mamba run -n pymc_env python -m ipykernel install --user \
    --name pymc_env --display-name "Python (pymc_env)"

# Install JupyterLab in base environment
RUN mamba install -y jupyterlab && mamba clean -afy

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]


# extra metadata
LABEL org.opencontainers.image.source="https://github.com/ijapesigan/docker-pymc" \
      org.opencontainers.image.authors="Ivan Jacob Agaloos Pesigan <ijapesigan@gmail.com>"
