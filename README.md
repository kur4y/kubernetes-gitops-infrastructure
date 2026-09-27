# Kubernetes & GitOps Infrastructure (Inception-of-Things)

## Overview
A hands-on system administration project exploring container orchestration and GitOps, built as part of the 42 School curriculum. It covers provisioning a lightweight Kubernetes cluster (K3s) with Vagrant, configuring host-based Ingress routing, and implementing a full GitOps continuous delivery pipeline with Argo CD and K3d.

## Architecture & Phases

**Part 1 — Multi-Node Cluster Provisioning**
- Two VMs (controller + agent) provisioned with Vagrant, using static private IPs.
- K3s installed in server mode on the controller, agent mode on the worker.
- Passwordless SSH access between host and both machines.
- Minimal footprint: 1 CPU / 1024 MB RAM per node.

**Part 2 — Ingress & Multi-Replica Routing**
- Single K3s node running three sample web applications.
- Host-based routing via Ingress (`app1.com`, `app2.com`, default fallback).
- One application scaled to 3 replicas to demonstrate load distribution.

**Part 3 — GitOps & Continuous Delivery**
- K3d cluster (Kubernetes-in-Docker) provisioned without Vagrant.
- Argo CD deployed in its own namespace, watching a separate public GitHub repo.
- Application automatically deployed and kept in sync in the `dev` namespace.
- Switching the image tag (`v1` → `v2`) in Git triggers an automatic redeploy — no manual `kubectl apply` needed.

## Technical Stack
- **Orchestration:** K3s, K3d, Kubernetes
- **Virtualization:** Vagrant, VirtualBox
- **GitOps:** Argo CD
- **Containerization:** Docker
- **Networking:** Traefik Ingress

## Repository Structure
```
.
├── p1/
│   ├── Vagrantfile
│   └── scripts/
├── p2/
│   ├── Vagrantfile
│   ├── scripts/
│   └── confs/
└── p3/
    ├── Vagrantfile
    ├── scripts/
    └── confs/
```

## Notes
The GitOps application source lives in a separate repository, referenced by `p3/confs/argocd-app.yaml`, so Argo CD can track and sync it independently from the infrastructure code here.

---
*Educational project — built and tested in isolated local VMs, not intended for production use.*