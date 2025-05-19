#!/bin/bash

# Function to display help message
show_help() {
    echo "Usage: docker_killall [OPTIONS]"
    echo "Completely prune Docker environment (containers, images, volumes, networks, and build cache)."
    echo ""
    echo "Options:"
    echo "  --help          Display this help message and exit"
    echo "  -now, --now     Execute without confirmation prompt"
    echo ""
    echo "With no options, the script will ask for confirmation before proceeding."
}

# Function to perform the docker cleanup
perform_cleanup() {
    echo "Stopping all running containers..."
    docker stop $(docker ps -a -q) 2>/dev/null || true

    echo "Removing all containers..."
    docker rm $(docker ps -a -q) 2>/dev/null || true

    echo "Removing all images..."
    docker rmi $(docker images -q) -f 2>/dev/null || true

    echo "Removing all volumes..."
    docker volume prune -f 2>/dev/null || true

    echo "Removing all networks..."
    docker network prune -f 2>/dev/null || true

    echo "Removing build cache and dangling resources..."
    docker system prune -a --volumes -f 2>/dev/null || true

    echo "Docker environment completely cleaned!"
}

# Parse command-line arguments
if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ "$1" == "-now" || "$1" == "--now" ]]; then
    echo "Executing immediate Docker cleanup..."
    perform_cleanup
else
    # Ask for confirmation
    read -p "Do you want to do this? You will lose all Docker material. Type 'yes' to proceed: " confirmation
    if [[ "$confirmation" == "yes" ]]; then
        perform_cleanup
    else
        echo "Operation cancelled."
        exit 1
    fi
fi
