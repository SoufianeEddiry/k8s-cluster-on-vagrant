#!/bin/bash
kubeadm init --apiserver-advertise-address=192.168.33.50 --pod-network-cidr=10.32.0.0/12  --token 0xcsd9.dkdl9202mdkdsa46
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
