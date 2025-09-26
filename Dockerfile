FROM condaforge/mambaforge:latest

WORKDIR /app

# Create a single env with everything you need
# (ipykernel is still required for Python notebooks to run)
RUN mamba create -y -n pymc_env -c conda-forge \
      python=3.11 \
      "pymc>=5" \
      pymc-experimental \
      pymc-marketing \
      numpyro \
      blackjax \
      nutpie \
      jupyterlab \
      ipykernel \
      ipywidgets \
      statsmodels \
  && mamba clean -afy

# Expose Jupyter
EXPOSE 8888

# Launch JupyterLab *from inside* the env, no kernel registration needed
CMD ["bash", "-lc", "mamba run -n pymc_env jupyter lab --ip=0.0.0.0 --allow-root --no-browser"]

# extra metadata
LABEL org.opencontainers.image.source="https://github.com/ijapesigan/docker-pymc" \
      org.opencontainers.image.authors="Ivan Jacob Agaloos Pesigan <ijapesigan@gmail.com>"
