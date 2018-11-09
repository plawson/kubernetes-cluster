#/bin/bash

function start_vm {
	VBoxManage startvm "$1" --type headless
}
function is_vm_running {
	vboxmanage showvminfo "$1" | grep -c "running (since"
}

if [[ $# -ne 1 ]]; then
	echo "usage: $0 all|nodes|master|<VM_NAME>"
	exit
fi

if [[ "$1" == "all" ]]; then
	VMS=$(vboxmanage list vms | awk '{print $1}' | sed -e 's/"//g')
	for VM in $VMS
	do
		if [[ $(is_vm_running $VM) -eq 0 ]];then
			echo "Startig VM: $VM..."
			start_vm $VM
		fi
	done

elif [[ "$1" == "nodes" ]]; then
	VMS=$(vboxmanage list vms | grep k8s-node | awk '{print $1}' | sed -e 's/"//g')
	for VM in $VMS
	do
		if [[ $(is_vm_running $VM) -eq 0 ]];then
			echo "Starting VM: $VM..."
			start_vm $VM
		fi
	done

elif [[ "$1" == "master" ]]; then
	VMS=$(vboxmanage list vms | grep k8s-master | awk '{print $1}' | sed -e 's/"//g')
	for VM in $VMS
	do
		if [[ $(is_vm_running $VM) -eq 0 ]];then
			echo "Starting VM: $VM..."
			start_vm $VM
		fi
	done

else
	if [[ $(is_vm_running $1) -eq 0 ]];then
		echo "Starting VM: $1..."
		start_vm $1
	else
		echo "VM $1 is running"
	fi
fi
