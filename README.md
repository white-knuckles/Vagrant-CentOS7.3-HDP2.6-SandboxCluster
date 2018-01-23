## Background
Create and deploy a 4-node Hortonworks HDP 2.6.0 cluster in a sandbox virtual environment using Vagrant for VM control. This is based on using Mac OSX and Parallels as the provider and is an update and used the approach published by [Constantin Stanca](https://community.hortonworks.com/users/3486/cstanca.html).
  
## Preparation:
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

## Installation - prepare machines & install HDP 2.6
The Vagrantfile is configured to create 4 VM's configured with private networking. This includes 1x Ambari server, 1x master & 2x slaves. 

### Step 1: prepare the ambari VM
Get local repo for Ambari suited to OS (CentOS7.3 in this case)
        
```
vagrant ssh ambari1
        
sudo su -
        
cd /etc/yum.repos.d 
        
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
```

### Step 2. Generate ssh keys on ambari1 server
```
ssh-keygen

cp /root/.ssh/id_rsa /hdpdata (copy id_rsa to vagrant or shared folder)

cd /root/.ssh

cat id_rsa.pub >> authorized_keys
```

The private key will be needed for Ambari server setup in the cluster configuration page so copy it to your host if thats where you will run the setup from. 

### Step 3: Start up cluster and prepare servers
```
vagrant up master1

vagrant up slave 1

vagrant up slave 2
```

SSH back into the ambari server and copy SSH keys to cluster servers
```
ssh-copy-id -f root@master1.local

ssh-copy-id -f root@slave1.local

ssh-copy-id -f root@slave2.local
```

Verify this has worked successfully by creating an SSH session to each machine and veryify this connects successfully without requiring a password.

```
#do this on master1, slave1, slave2 etc.
ssh root@master1.local
```

Finally, update the hosts file of each server to include entries for all servers in the cluster. As an example:

```
192.168.0.11 ambari1.local ambari1
192.168.0.12 master1.local master1
192.168.0.21 slave1.local slave1
192.168.0.22 slave2.local slave2
```

### Step 4: Install & configure Ambari
We're finally ready to install Ambari and configure the cluster. SSH back into the Ambari server and run the following commands:

```
yum install ambari-server

ambari-server setup
```

Post installation - open a browser window to http://ambari.local:8080/
Log in as admin and proceed to create a cluster, add servers using their FQDN and upload the private key for SSH. Installation of the Ambari agent and configuration of services can now be performed. 
