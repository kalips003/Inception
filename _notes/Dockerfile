#//////////////////////////////////////////////////////////////////////////////]
FROM
    Convention: FROM <distribution>:<version-or-tag>
    Specifies base image.
    Must be first non-comment instruction.
    Example: FROM debian:bookworm-slim → start from minimal Debian.
FROM debian:stable-slim

#//////////////////////////////////////////////////////////////////////////////]
RUN
    Executes a command during build.
    Changes are saved into a new image layer.
RUN apt-get update && apt-get install -y curl

#//////////////////////////////////////////////////////////////////////////////]
COPY
    Copies files from host into image filesystem.
    Syntax: COPY <src from build context perspective> <dest>
COPY <src> <dest>

#//////////////////////////////////////////////////////////////////////////////]
ADD
    Like COPY but supports URLs and automatic extraction of archives.
    Use COPY unless you need archive unpacking.

#//////////////////////////////////////////////////////////////////////////////]
WORKDIR
    Sets the working directory for subsequent instructions and for container runtime.
WORKDIR /app

#//////////////////////////////////////////////////////////////////////////////]
ENV
    Sets environment variables inside the image. (default, overridden by run -e)
ENV DB_USER=myuser

#//////////////////////////////////////////////////////////////////////////////]
EXPOSE
    Declares which ports the container listens on.
    Does not publish the port; informs users and tools.
	but later needs: docker run -p 8080:80 nginx (HOST:8080  →  CONTAINER:80)
EXPOSE 80

#//////////////////////////////////////////////////////////////////////////////]
CMD
    Default command when container starts.
    Can be overridden with docker run <image> <command>.
    Example: CMD ["nginx", "-g", "daemon off;"]
	Can be overridden easily: docker run myimage ls
CMD ["echo", "Hello"]

#//////////////////////////////////////////////////////////////////////////////]
ENTRYPOINT
    Sets the main executable that always runs in the container.
    CMD arguments are appended if ENTRYPOINT is set.
	overridden by --entrypoint
	docker run myimage Hello
ENTRYPOINT ["echo"]

#//////////////////////////////////////////////////////////////////////////////]
VOLUME
    Declares mount points for persistent data.
	When a container is created, Docker:
		Automatically creates an anonymous volume
		Mounts it at /data
	overridden by run -v
VOLUME ["/data"]

#//////////////////////////////////////////////////////////////////////////////]
USER
    Sets the user to run subsequent commands or container process.

#//////////////////////////////////////////////////////////////////////////////]
ARG
    Build-time variable, accessible only during docker build.
	Can be overridden with --build-arg
ARG VERSION=1.

#//////////////////////////////////////////////////////////////////////////////]
LABEL
    Adds metadata to the image.
LABEL maintainer="me@example.om"

#//////////////////////////////////////////////////////////////////////////////]
ONBUILD
    Delays instruction execution until a child image is built from this one.

#//////////////////////////////////////////////////////////////////////////////]
STOPSIGNAL
    Defines which signal stops the container (default: SIGTERM).
