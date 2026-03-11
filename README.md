# Kubernetes & GitOps Infrastructure (Inception-of-Things)

## 📜 Overview
This project is an advanced system administration exercise focused on container orchestration at scale. It demonstrates the deployment of a lightweight Kubernetes cluster (K3s) and the implementation of a modern GitOps continuous delivery pipeline using Argo CD.

## 🏗️ Architecture & Phases
The project is divided into three progressive tiers of infrastructure complexity:

* **Part 1: Hybrid Cluster Provisioning**
  - Automation of a multi-node cluster (Server/Worker) using **Vagrant**.
  - Internal networking with static IP assignment (192.168.56.x).
  - Strict resource optimization (1 CPU / 512MB RAM per node).

* **Part 2: Advanced Routing & Scalability**
  - High-availability application management with **K3s Ingress**.
  - Host-based routing for multiple web applications (app1.com, app2.com).
  - Multi-replica deployment strategies to ensure service availability.

* **Part 3: GitOps & Continuous Delivery**
  - Transition to **K3d** for container-based Kubernetes environments.
  - Implementation of **Argo CD** for automated synchronization between GitHub and the cluster.
  - Version-controlled deployments (v1/v2) with zero-touch updates.

## 🛠️ Technical Stack
* **Orchestration:** K3s, K3d, Kubernetes
* **Virtualization:** Vagrant
* **GitOps:** Argo CD
* **Containerization:** Docker
* **Networking:** Ingress Controllers (Traefik)

## 🚀 Usage
The repository is structured to separate each phase of the infrastructure development:
- `p1/`: Vagrant configuration and initial cluster setup.
- `p2/`: Application manifests and Ingress routing rules.
- `p3/`: K3d scripts and Argo CD GitOps configuration.

---
*Disclaimer: This repository is for educational purposes. All configurations are designed to run in isolated virtual environments.*