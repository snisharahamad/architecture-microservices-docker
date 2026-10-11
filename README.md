# Modular Container Infrastructure (SecOps & Routing)

A decoupled, containerized architecture behind a Traefik reverse proxy, designed for modular deployment, centralized management, and secure remote access.

This infrastructure leverages multiple Docker Compose stacks orchestrated by a central Bash script, allowing independent scaling, maintenance, and strict fault isolation.

## 🏗️ Architecture Layout

The repository is structured into four distinct functional modules:

* **`infra-traefik/`**: The core reverse proxy. Dynamically routes HTTP/HTTPS traffic to the appropriate containers based on labels.
* **`infra-vpn/`**: A secure WireGuard VPN server (`wg-easy`), providing remote access to the internal network.
* **`infra-web/`**: The public-facing web stack (Nginx serving static content).
* **`infra-tools/`**: Internal administration stack featuring Portainer CE.
* **`manager.sh`**: A centralized bash orchestrator to easily deploy (`up`) or teardown (`down`) all stacks simultaneously.

## 🚀 Key Features

* **Modular Deployment:** Stacks are decoupled. Services can be maintained independently without bringing down the entire infrastructure.
* **Dynamic Routing:** Traefik dynamically discovers running containers via Docker socket integration.
* **Secure Secret Management:** Strict isolation of sensitive data (password hashes, IPs) using `.env` files, preventing repository secret leakage.
* **Secure Access:** Built-in VPN gateway for secure administration of the Docker network.

## 🛠️ Deployment & Usage

*Requirement: Docker and Docker Compose must be installed on the host.*

**1. Clone the repository**

    git clone https://github.com/snisharahamad/architecture-microservices-docker.git
    cd architecture-microservices-docker

**2. Configure Secrets (Crucial)**
Security is built-in. You must define your environment variables before starting the VPN stack to avoid exposing sensitive data.

    cd infra-vpn
    cp .env.example .env
    # Edit the .env file with your specific variables (e.g., VPN_PASSWORD_HASH, VPN_HOST_IP)
    nano .env
    cd ..

**3. Deploy the infrastructure**
Use the provided bash script to spin up all modular stacks in the correct order:

    chmod +x manager.sh
    ./manager.sh up

**4. Shutdown the infrastructure**
To safely stop and remove all running containers across all stacks:

    ./manager.sh down
