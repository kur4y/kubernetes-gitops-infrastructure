#!/bin/bash

# prevent apt from prompting for user input during installation
export DEBIAN_FRONTEND=noninteractive

# system prerequisites
# update package list and install basic dependencies
if ! command -v curl &> /dev/null; then
    sudo apt-get update -y
    sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common
fi

# docker installation
# if it is not already present
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    #grant docker permissions to the vagrant user
    sudo usermod -aG docker $USER
fi

# kubectl installation
# kubernetes command-line tool
if ! command -v kubectl &> /dev/null; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi

# k3d installation
# install the k3d wraper to run k3s in docker
if ! command -v k3d &> /dev/null; then
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
fi

# cluster & infra. initialization
# create k3d cluster with explicit port mappings
# 8888 -> routes to the app via loadbalancer
# 8080 -> routes to node port 30080 (where argo cd will be exposed)
k3d cluster create iot-cluster \
    -p "8888:8888@loadbalancer" \
    -p "8080:30080@server:0"

# wait for the cluster to be ready
sleep 10

# create namespaces
kubectl create namespace argocd
kubectl create namespace dev

# argo cd deployment
# official argo cd install. manifest to argocd namespace
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml --server-side

# wait for the argo cd server deployment
sleep 5
kubectl wait --for=condition=Available deployment/argocd-server -n argocd --timeout=300s

# expose argo cd securely
# patch the service to use a nodeport so k3d can route host traffic to it
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort", "ports": [{"port": 443, "nodePort": 30080}]}}'

echo "Cluster and Argo CD are successfully installed and running."
