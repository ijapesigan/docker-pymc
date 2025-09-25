FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential graphviz && rm -rf /var/lib/apt/lists/*

RUN pip install -U uv && \
    uv pip install --system \
      jupyterlab \
      "pymc>=5.15" "jax[cpu]>=0.4.30" "jaxlib>=0.4.30" \
      blackjax arviz statsmodels graphviz

ENV PYTENSOR_FLAGS="cxx=/usr/bin/g++"
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token="]
# extra metadata
LABEL org.opencontainers.image.source="https://github.com/ijapesigan/docker-pymc" \
      org.opencontainers.image.authors="Ivan Jacob Agaloos Pesigan <ijapesigan@gmail.com>"
