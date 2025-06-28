#!/usr/bin/env bash
#########################################
#Developed by: Ron Negrov
#Purpose: The installer script to install all dependencies and install the application
#Date: 28/06/2025
#Version: 0.0.0
##########################################
. /etc/os-release
NULL = /dev/null
LOGFILE = /var/log/ronstaller.log
DDIR="./dependencies"
ADIR="./application"

function main(){
Install_dependencies
package_build
run_container
}

function Install_dependencies() {
    echo "[INFO] Starting dependency installation" >> "$LOGFILE"
    case "$ID" in
        debian|ubuntu|kali)
            for deb in "$DDIR"/*.deb; do
                echo "[INFO] Installing $deb" | tee -a "$LOGFILE"
                if sudo apt install -y "$deb" >> "$LOGFILE" 2>&1; then
                    echo "[SUCCESS] Installed $deb" >> "$LOGFILE"
                else
                    echo "[ERROR] Failed to install $deb" >> "$LOGFILE"
                fi
            done
            ;;
        *)
            echo "[ERROR] Unsupported OS: $ID" | tee -a "$LOGFILE"
            exit 1
            ;;
    esac
    echo "[INFO] Dependency installation complete" >> "$LOGFILE"
}

function package_build() {
    echo "Building Docker image from $ADIR"
    docker build -t ronstaller_image "$ADIR" >> "$LOGFILE" 2>&1

    if [[ $? -eq 0 ]]; then
        echo "[INFO] Docker image built successfully" | tee -a "$LOGFILE"
    else
        echo "[ERROR] Docker build failed" | tee -a "$LOGFILE"
        exit 1
    fi
}


function run_container() {
    echo "[INFO] Starting container run" >> "$LOGFILE"

    if ! command -v docker &>/dev/null; then
        echo "[ERROR] Docker is not installed or not in PATH" | tee -a "$LOGFILE"
        exit 1
    fi

    if ! docker image ls | grep -q nginx; then
        echo "[INFO] nginx image not found. Pulling from Docker Hub..." >> "$LOGFILE"
        if ! docker pull nginx >> "$LOGFILE" 2>&1; then
            echo "[ERROR] Failed to pull nginx image" | tee -a "$LOGFILE"
            exit 1
        fi
    fi

    echo "[INFO] Running nginx container..." >> "$LOGFILE"
    if docker run -d -p 8000:80 nginx >> "$LOGFILE" 2>&1; then
        echo "[SUCCESS] Nginx container is running on port 8000" >> "$LOGFILE"
    else
        echo "[ERROR] Failed to run nginx container" | tee -a "$LOGFILE"
        exit 1
    fi
}