#!/usr/bin/env bash
#########################################
# Developed by: Ron Negrov
# Purpose: The installer script to install all dependencies and install the application
# Date: 28/06/2025
# Version: 0.0.1
#########################################

source /etc/os-release
NULL=/dev/null
LOGFILE="/var/log/ronstaller.log"
DDIR="./dependencies"
ADIR="./application"


main() {
  log "Installer started"
  if ! check_docker; then
    install_dependencies
  fi
  package_build
  run_container
  log "Installer finished"
}

check_docker() {
 if command -v docker &> /dev/null; then
    log "Docker is installed"
    return 0
  else
    log "Docker is NOT installed"
    return 1
  fi
}

install_dependencies() {
  case "$ID" in
    debian|ubuntu|kali)
      for deb in "$DDIR"/*.deb; do
        log "Installing $deb"
        sudo dpkg -i "$deb" 2>&1 | tee -a "$LOGFILE"
      done
      ;;
    *)
      log "Unsupported OS: $ID"
      exit 1
      ;;
  esac
}

package_build() {
  log "Building Docker image"
  if docker build -t my_app_image "$ADIR" >> "$LOGFILE" 2>&1; then
    log "Docker image built successfully"
  else
    log "Failed to build Docker image"
    exit 1
  fi
}

run_container() {
  if ! docker image inspect nginx:latest >"$NULL" 2>&1; then
    log "nginx image not found. Pulling from Docker Hub"
    if ! docker pull nginx:latest >> "$LOGFILE" 2>&1; then
      log "Failed to pull nginx image"
      exit 1
    fi
  fi

  docker run -d -p 8000:80 nginx >> "$LOGFILE" 2>&1
  if [[ $? -eq 0 ]]; then
    log "nginx container started successfully"
  else
    log "Failed to start nginx container"
    exit 1
  fi
}

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

main "$@"