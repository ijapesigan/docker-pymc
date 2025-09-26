FROM condaforge/mambaforge:latest

WORKDIR /app

# Copy the environment.yml into the image
COPY scripts/environment.yml /tmp/environment.yml

# Build the environment
RUN mamba env create -f /tmp/environment.yml && mamba clean -afy

# Expose Jupyter
EXPOSE 8888

# Launch JupyterLab *from inside* the env, no kernel registration needed
CMD ["bash", "-lc", "mamba run -n pymc_env jupyter lab --ip=0.0.0.0 --allow-root --no-browser"]

# extra metadata
LABEL org.opencontainers.image.source="https://github.com/ijapesigan/docker-pymc" \
      org.opencontainers.image.authors="Ivan Jacob Agaloos Pesigan <ijapesigan@gmail.com>"
