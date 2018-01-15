###########################################
############# Change Hostname #############
###########################################
new_hostname="kube-node10"
hostn=$(cat /etc/hostname)
sudo sed -i "s/$hostn/$new_hostname/g" /etc/hosts
sudo sed -i "s/$hostn/$new_hostname/g" /etc/hostname
#sudo reboot
