# DEV_DOC.md

## Overview

This project deploys a web infrastructure using **Docker** and **Docker Compose**.  
It consists of three main services:

- **Nginx** – HTTPS web server and reverse proxy
- **WordPress** – PHP application serving the website
- **MariaDB** – Database used by WordPress

Each service runs inside its own **container**, connected through a **Docker network**.  
Persistent data is stored using **Docker volumes**.

---

## Prerequisites

Before running the project, the following tools must be installed:

- **Docker**
- **Docker Compose**
- **Make**

You can verify the installation with:

```bash
docker --version
docker compose version
make --version
```

---

## Project Configuration

Configuration values and credentials are stored in a **`.env` file** located in the project root.

Typical variables include:

```
MYSQL_DATABASE
MYSQL_USER
MYSQL_PASSWORD
MYSQL_ROOT_PASSWORD

WP_ADMIN_USER
WP_ADMIN_PASSWORD
WP_ADMIN_EMAIL
```

These variables are used by **Docker Compose** when creating the containers.

---

## Building and Launching the Project

From the root directory of the repository:

---
## Start the Project

From the root of the repository:

```bash
make a
```
## Restart the Project
```bash
make b
```

---

## Stop / Restart the Project

```bash
make stop
make start
```

To also remove the stored data (volumes):
## Remove Project

```bash
make down
make fclean
```

---
It will:

1. Build Docker images
2. Create the containers
3. Create the Docker network
4. Create the volumes
5. Start all services

---

## Managing Containers

### List running containers

```bash
docker ps
```

### View container logs

```bash
docker compose logs
```

Or for a specific service:

```bash
docker compose logs nginx
docker compose logs wordpress
docker compose logs mariadb
```

---

## Managing Volumes

Docker volumes are used to store persistent data for:

- **WordPress files**
- **MariaDB database**

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect <volume_name>
```

Remove volumes when stopping the project:

```bash
docker compose down -v
```

---

## Data Persistence

Two main volumes are used:

- **WordPress volume**
  - stores website files and uploads
- **MariaDB volume**
  - stores database tables and records

These volumes allow the data to **persist even if containers are recreated or restarted**.

The volumes are automatically created by **Docker Compose** and mounted inside the containers.

---

## Project Structure (example)

```
.
├── Makefile
├── docker-compose.yml
├── .env
├── srcs/
│   ├── requirements/
│   │   ├── nginx/
│   │   ├── wordpress/
│   │   └── mariadb/
│   └── docker-compose.yml
```

Each service contains its own:

- **Dockerfile**
- configuration files
- startup scripts

---

## Cleaning the Project

To stop the containers:

```bash
docker compose down
```

To remove containers **and volumes**:

```bash
docker compose down -v
```

To remove unused Docker resources:

```bash
docker system prune -af
```

This completely resets the development environment.