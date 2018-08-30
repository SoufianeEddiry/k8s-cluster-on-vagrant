#!/bin/bash
cat <<EOF > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.50 master1.internal master1
192.168.33.51 node1.internal node1

EOF

#installing some dependency packages
yum -y install wget telnet git

#Adding docker repo
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

#Installing and starting docker
yum -y install docker-ce;systemctl enable docker;systemctl start docker

# kubelet requires swap off
swapoff -a

#make swap off even machine restart
sed -i '/swap/ s/^/#/' /etc/fstab

#disableing SELINUX
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config


#adding kubernetes repo
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubelet kubeadm kubectl nfs-utils


cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

sed -i "s/cgroup-driver=systemd/cgroup-driver=cgroupfs/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

systemctl enable kubelet
systemctl start kubelet