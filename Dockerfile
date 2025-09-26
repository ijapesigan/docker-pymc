FROM condaforge/mambaforge:latest

WORKDIR /app

# Copy the environment.yml into the image
COPY scripts/environment.yml /tmp/environment.yml

# Update the base environment
RUN mamba env update -n base -f /tmp/environment.yml && mamba clean -afy

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]

# extra metadata
LABEL org.opencontainers.image.source="https://github.com/ijapesigan/docker-pymc" \
      org.opencontainers.image.authors="Ivan Jacob Agaloos Pesigan <ijapesigan@gmail.com>"
