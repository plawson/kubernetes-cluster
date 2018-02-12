#!/bin/bash

for VM in $(vboxmanage list vms | awk '{print $1}' | sed -e 's/"//g')
do
	MAC=$(vboxmanage showvminfo $VM | grep "NIC 1" | sed -r -e 's/^.*MAC: (.*), Attachment: .*$/\1/' | tr '[:upper:]' '[:lower:]')
	echo "$VM: $MAC"
done
