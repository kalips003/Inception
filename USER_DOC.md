# USER_DOC.md

## Services

This project deploys a small web infrastructure using **Docker Compose** with three services:

- **Nginx** – Web server handling HTTPS requests.
- **WordPress** – Website content management system.
- **MariaDB** – Database used by WordPress.

Each service runs in its own container and communicates through a Docker network.  
Website and database data are stored in **Docker volumes** to ensure persistence.

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

## Access the Website

Open a browser and go to:

```
https://agallon.42.fr
```

The browser may show a warning because the project uses a **self-signed SSL certificate**.  
Accept the warning to continue.

---

## WordPress Administration Panel

Access the admin interface at:

```
https://agallon.42.fr/wp-admin
```

Login using the WordPress administrator credentials.

---

## Credentials

Credentials are defined in the **`srcs/.env` file**

Example variables:

```
MYSQL_DATABASE
MYSQL_USER
MYSQL_PASSWORD
MYSQL_ROOT_PASSWORD
WP_ADMIN_USER
WP_ADMIN_PASSWORD
```

---

## Check That Services Are Running

List running containers:

```bash
docker ps
```

Check logs:

```bash
docker compose logs
```

If everything is working correctly, the **nginx**, **wordpress**, and **mariadb** containers should appear as running.