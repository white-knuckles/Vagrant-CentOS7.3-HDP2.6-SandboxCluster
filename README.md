# Background
Create and deploy a 4-node Hortonworks HDP 2.6.0 cluster in a sandbox virtual environment using Vagrant for VM control. This is based on using Mac OSX and Parallels as the provider and is an update and used the approach published by [Constantin Stanca](https://community.hortonworks.com/users/3486/cstanca.html).
  
# Preparation:
1. Download and install Vagrant for your host OS
1. Check for your provider - install if required (e.g. parallels, virtualbox, VMWare etc)
1. Download and install git client for your host
1. Once your local environment is configured, open a command prompt and navigate where you wish to create and run the VM files. When ready, run the following commands:
```
mkdir hdpcluster

git clone https://github.com/white-knuckles/Vagrant-CentOS7.3-HDP2.6-SandboxCluster.git

vagrant validate
```
You will need to edit the Vagrant file if using a different provider.

# Installation - prepare machines & install HDP 2.6
The Vagrantfile is configured to create 4 VM's configured with private networking. These 
    1. Ambari server, master & 2x slaves
1. For install - prepare the ambari VM
    1. Get local repo for Ambari suited to OS (CentOS7.3 in this case)
        1. vagrant ssh ambari1
        1. sudo su -
        1. cd /etc/yum.repos.d 
        1. wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
        1. yum repolist (check to verify the repo has been configured)
    1. Generate ssh keys on ambari1
        1. ssh-keygen (enter for standard dir, enter for no passphrase otherwise enter in)
        1. cp /root/.ssh/id_rsa /hdpdata (copy id_rsa to vagrant or shared folder)
        1. cd /root/.ssh
        1. cat id_rsa.pub >> authorized_keys
    1. Install & configure Ambari
        1. Exit SSH, return to host: Run up cluster machines (master1, slave1, slave2)
        1. vagrant ssh ambari1 (log back into ambari server)
        1. yum install ambari-server
        1. ambari-server setup
