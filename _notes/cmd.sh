#!/bin/bash

# ------------------------------------------------------------
docker build <args> <build context>
docker build
    -t name:tag (--tag)
    -f path/to/Dockerfile (--file)
    --no-cache → ignore previous layers; rebuild from scratch (doesnt reuse cached layers)
    --pull → always try to fetch newer base image.
    --cache-from
    --cache-to
    --build-arg KEY=val → pass build-time variables to ARG instructions.
    --platform linux/amd64
    --target builder → (FROM debian:bookworm AS builder)
    (modern)
    --secret
    --ssh
    --progress=plain
    -o --output type=tar,dest=image.tar
    --label version=1.0
    --squash
    --network
    --build-context
    --memory
    --cpus
  /path/to/context

# ------------------------------------------------------------
docker run <args> <img to run>
docker run
	-d # --detach mode (run in background).
	-it # --interactive → keep STDIN open (interactive), --tty → allocate a terminal
	--name mycontainer1 # if not, one given automatically: adjective_scientist
	-p HOST:CONTAINER # → --publish container port to host.
	-v /host_path:/container_path
	--rm # remove it from docker ps list (otherwise, its stays with status exited, and can be restarted)
	-e --env KEY=value
	--env-file /file_for_env # → load many env vars from file.
	--network mynetwork1
	--restart=always # --restart=no (default) --restart=on-failure:5
	--entrypoint ["bash"] img -c "nginx -g 'daemon off;'" # → override image’s default entrypoint.
	--user UID:GID # → run process as given user.
	--cpus=2
	-m 2g --memory=512m # → Limit container to 512 MB RAM
  /image_name_to_run



# ------------------------------------------------------------
docker ps (-a --all)
-a → show all containers, even stopped ones.

# ------------------------------------------------------------
docker images
-a → show intermediate image layers.

# ------------------------------------------------------------
docker exec # Execute a command in a running container
# docker exec -it app2 sh
-it → interactive session in a running container.

# ------------------------------------------------------------
docker logs
-f → follow log output live.

# ------------------------------------------------------------
docker rm <container>
docker rmi <image>

# ------------------------------------------------------------
docker compose

# ======================================================================================================
# Registry & Image Distribution
docker pull IMAGE[:TAG]                # Download an image from a registry
docker push IMAGE[:TAG]                # Upload an image to a registry
docker login [REGISTRY]                # Authenticate to a registry
docker logout [REGISTRY]               # Log out from a registry
docker search TERM                     # Search Docker Hub for images

# ======================================================================================================
# Info & System
docker version                         # Show Docker version information
docker info                            # Display system-wide information
docker system [subcommand]             # Manage Docker system (prune, df, etc.)
docker events                          # Stream real-time daemon events

# ======================================================================================================
# Build & Compose
docker builder [subcommand]            # Manage builds
docker buildx [subcommand]             # Extended build features (multi-arch, etc.)
docker compose -f FILE -p PROJECT_NAME up -d   # Run multi-container app (detached)
docker compose down                    # Stop and remove compose stack

# ======================================================================================================
# Image Management
docker build -t NAME .                 # Build image from Dockerfile
docker image ls                        # List images (== docker images)
docker image rm IMAGE                  # Remove image
docker history IMAGE                   # Show image layer history
docker inspect IMAGE                   # Low-level image details
docker tag SRC_IMAGE TARGET_IMAGE      # Create new tag for image
docker save IMAGE > file.tar           # Save image to tar archive
docker load < file.tar                 # Load image from tar archive
docker import file.tar                 # Create image from tarball
docker manifest [subcommand]           # Manage image manifests
docker trust [subcommand]              # Manage image trust

# ======================================================================================================
# Container Management
docker run IMAGE                       # Create and start container
docker create IMAGE                    # Create container (do not start)
docker start CONTAINER                 # Start stopped container
docker stop CONTAINER                  # Gracefully stop container
docker restart CONTAINER               # Restart container
docker kill CONTAINER                  # Force stop container
docker rm CONTAINER                    # Remove container
docker container ls                    # List containers
docker logs CONTAINER                  # Show container logs
docker attach CONTAINER                # Attach terminal to running container
docker exec -it CONTAINER bash         # Run command inside running container
docker cp SRC DEST                     # Copy files container <-> host
docker rename OLD NEW                  # Rename container
docker pause CONTAINER                 # Pause container processes
docker unpause CONTAINER               # Unpause container
docker stats                           # Live resource usage stats
docker top CONTAINER                   # Show running processes
docker port CONTAINER                  # Show port mappings
docker wait CONTAINER                  # Wait until container stops
docker update CONTAINER --memory=512m  # Update container limits
docker diff CONTAINER                  # Show filesystem changes
docker commit CONTAINER NEW_IMAGE      # Create image from container
docker export CONTAINER > file.tar     # Export container FS

# ======================================================================================================
# Networking
docker network create NAME             # Create network
docker network ls                      # List networks
docker network inspect NAME            # Inspect network
docker network connect NET CONTAINER   # Connect container to network
docker network disconnect NET CONTAINER # Disconnect container
docker network rm NAME                 # Remove network
docker network prune                   # Remove unused networks

# ======================================================================================================
# Volumes
docker volume create NAME              # Create volume
docker volume ls                       # List volumes
docker volume inspect NAME             # Inspect volume
docker volume rm NAME                  # Remove volume
docker volume prune                    # Remove unused volumes

# ======================================================================================================
# Context & Plugins
docker context ls                      # List contexts
docker context use NAME                # Switch context
docker plugin ls                       # List plugins

# ======================================================================================================
# Swarm (Orchestration)
docker swarm init                      # Initialize swarm
docker swarm join                      # Join swarm
docker swarm leave                     # Leave swarm
docker service create IMAGE            # Create swarm service

