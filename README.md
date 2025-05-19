# Docker Cleanall

A simple yet powerful utility script to completely clean your Docker environment with a single command.

## Overview

`docker_cleanall` is a bash script that thoroughly purges your Docker environment, removing:

- All containers (running or stopped)
- All images (used or unused)
- All volumes
- All networks
- All build cache
- Any dangling resources

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/docker-cleanall.git

# Move to the directory
cd docker-cleanall

# Make the script executable
chmod +x docker_cleanall.sh

# Install it to your path (optional)
sudo cp docker_cleanall.sh /usr/local/bin/docker_cleanall
```

## Usage

```
Usage: docker_cleanall [OPTIONS]
Completely prune Docker environment (containers, images, volumes, networks, and build cache).

Options:
  --help          Display this help message and exit
  -now, --now     Execute without confirmation prompt

With no options, the script will ask for confirmation before proceeding.
```

### Examples

Run with confirmation prompt (default):
```bash
docker_cleanall
```

Run without confirmation:
```bash
docker_cleanall --now
```

Display help:
```bash
docker_cleanall --help
```

## Warning

**This script will remove ALL Docker resources on your system.** This includes:

- All containers, including stopped ones you might want to restart
- All images, which will need to be re-downloaded or rebuilt
- All volumes, which might contain data you want to keep
- All networks
- All build cache

Use with caution, especially in production environments.

## How It Works

The script executes the following Docker commands in sequence:

1. `docker stop $(docker ps -a -q)` - Stops all running containers
2. `docker rm $(docker ps -a -q)` - Removes all containers
3. `docker rmi $(docker images -q) -f` - Forcefully removes all images
4. `docker volume prune -f` - Removes all volumes
5. `docker network prune -f` - Removes all networks
6. `docker system prune -a --volumes -f` - Removes build cache and any remaining resources

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
