# Color Web Server

A minimal Docker web server that displays a page with a background color controlled by an environment variable.

## Usage

### Docker Compose

```bash
docker compose up
```

The current `docker-compose.yml` creates a rainbow of services:

| Service | Port | Color |
|---------|------|-------|
| web-red | 81 | red |
| web-orange | 82 | orange |
| web-yellow | 83 | yellow |
| web-green | 84 | green |
| web-blue | 85 | blue |
| web-indigo | 86 | indigo |
| web-violet | 87 | violet |

### Docker

```bash
docker build -t color-server .
docker run -p 8080:8080 -e COLOR=red color-server
```

Access at http://localhost:8080

## Build Script

`build.sh` builds multi-architecture images (ARM64/AMD64) and pushes to registries.

```bash
# Dev build - pushes to internal registry
./build.sh

# Prod build - pushes to internal registry and Docker Hub
./build.sh Prod
```

Requires `DOCKER_USER` and `DOCKER_PAT` environment variables.

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `COLOR`  | `blue`  | Any valid CSS color (e.g., `red`, `#ff5733`, `rgb(255,0,0)`) |
