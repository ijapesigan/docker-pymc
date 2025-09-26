FROM condaforge/mambaforge:latest

WORKDIR /app

# Copy your environment spec (must have: name: pymc_env)
COPY scripts/environment.yml /tmp/environment.yml

# Create the conda env. Use 'conda env create' so the pip: block is honored reliably.
RUN mamba update -n base -c conda-forge conda -y
RUN conda env create -f /tmp/environment.yml && conda clean -afy

# Register a Jupyter kernel for this env (cleaner than --user inside containers)
RUN mamba run -n pymc_env python -m ipykernel install \
    --sys-prefix \
    --name pymc_env \
    --display-name "Python (pymc_env)"

# Expose Jupyter
EXPOSE 8888

# Launch JupyterLab FROM the env so it's the default kernel
CMD ["bash", "-lc", "mamba run -n pymc_env jupyter lab --ip=0.0.0.0 --allow-root --no-browser"]

# Metadata
LABEL org.opencontainers.image.source="https://github.com/ijapesigan/docker-pymc" \
      org.opencontainers.image.authors="Ivan Jacob Agaloos Pesigan <ijapesigan@gmail.com>"
