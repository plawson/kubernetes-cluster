###########################################
############# Change Hostname #############
###########################################
# The new_hostname variable is updated by the iso 
# builder script
new_hostname="will-be-changed-by-iso-builder"
hostn=$(cat /etc/hostname)
sudo sed -i "s/$hostn/$new_hostname/g" /etc/hosts
sudo sed -i "s/$hostn/$new_hostname/g" /etc/hostname
#sudo reboot
###########################################
############ Ad universe repo  ############
###########################################
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository universe
sudo apt-get update
###########################################
############# Install Docker  #############
###########################################
#sudo apt-get update
#sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#sudo apt-get update
#sudo apt-get install docker-ce=17.03.0~ce-0~ubuntu-xenial -y
#sudo mkdir -p /custom
#sudo cp /tmp/daemon.json /custom/daemon.json
#sudo cp /tmp/custdocker /etc/init.d/custdocker
#sudo chmod 755 /etc/init.d/custdocker
#sudo update-rc.d custdocker defaults
###########################################
########### Install kubernetes  ###########
###########################################
#sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#sudo chmod 777 /etc/apt/sources.list.d
#sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
#deb http://apt.kubernetes.io/ kubernetes-xenial main
#EOF
#sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
#sudo chown root:root /etc/apt/sources.list.d/kubernetes.list
#sudo chmod 755 /etc/apt/sources.list.d/kubernetes.list
#sudo apt-get update
#sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
###########################################
########## Customize sudoers  #############
###########################################
sudo cp -f /tmp/k8s /etc/sudoers.d/k8s
###########################################
########## Install NFS client  ############
###########################################
sudo apt-get install -y nfs-common
###########################################
#######  Install python3 packages  ########
###########################################
sudo apt-get -y install python3-pip
sudo pip3 install websocket-client
sudo pip3 install kafka-python
###########################################
############# Turn off Swap  ##############
###########################################
sudo sed -i '/ swap / s/^/#/' /etc/fstab
###########################################
########## Customize /etc/host  ###########
###########################################
# I'm using static IPs. If you don't, comment in the following line
cat /tmp/vm_hosts | grep -v $new_hostname >>/etc/hosts
