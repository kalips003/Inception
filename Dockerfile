FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
CMD ["bash"]

# Everything needed to reproduce a running system:
# 1 Base OS — minimal filesystem (Alpine, Debian, etc.).
# 2 Installed software — packages, libraries, tools your app needs.
# 3 Configuration files — app configs, system configs.
# 4 Environment variables — values your app reads at runtime.
# 5 Startup command — what process runs first (CMD or ENTRYPOINT).
# 6 Ports to expose — which container ports map to the host.
# 7 Files to include — app code, static assets.

# Dockerfile → docker build → Image → docker run → Container
FROM
    Convention: FROM <distribution>:<version-or-tag>
    Specifies base image.
    Must be first non-comment instruction.
    Example: FROM debian:bookworm-slim → start from minimal Debian.
        FROM alpine:3.20 / ubuntu:24.04

RUN
    Executes a command during build.
    Changes are saved into a new image layer.
    Example: RUN apt-get update && apt-get install -y curl

COPY
    Copies files from host into image filesystem.
    Syntax: COPY <src> <dest>

ADD
    Like COPY but supports URLs and automatic extraction of archives.
    Use COPY unless you need archive unpacking.

WORKDIR
    Sets the working directory for subsequent instructions and for container runtime.
    Example: WORKDIR /app

ENV
    Sets environment variables inside the image.
    Example: ENV DB_USER=myuser

EXPOSE
    Declares which ports the container listens on.
    Does not publish the port; informs users and tools.

CMD
    Default command when container starts.
    Can be overridden with docker run <image> <command>.
    Example: CMD ["nginx", "-g", "daemon off;"]

ENTRYPOINT
    Sets the main executable that always runs in the container.
    CMD arguments are appended if ENTRYPOINT is set.

VOLUME
    Declares mount points for persistent data.
    Example: VOLUME /var/lib/mysql

USER
    Sets the user to run subsequent commands or container process.

ARG
    Build-time variable, accessible only during docker build.
    Example: ARG VERSION=1.

LABEL
    Adds metadata to the image.
    Example: LABEL maintainer="me@example.om"

ONBUILD
    Delays instruction execution until a child image is built from this one.

STOPSIGNAL
    Defines which signal stops the container (default: SIGTERM).