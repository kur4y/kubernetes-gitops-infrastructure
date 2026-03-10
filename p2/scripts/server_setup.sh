#!/bin/bash

# install k3s in server mode, binding to the private network interface
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110 --flannel-iface=eth1" sh -

# wait for k3s to be fully initialized and traefik to be deployed
sleep 20

# adjust perm. for the vagrant user to use kubectl
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

# apply the kubernetes manifests from the shared confs dir.
kubectl apply -f /vagrant/confs/apps.yaml