#/bin/bash

function stop_vm {
	VBoxManage controlvm "$1" poweroff
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
		if [[ $(is_vm_running $VM) -eq 1 ]];then
			echo "Stopping VM: $VM..."
			stop_vm $VM
		fi
	done

elif [[ "$1" == "nodes" ]]; then
	VMS=$(vboxmanage list vms | grep kube-node | awk '{print $1}' | sed -e 's/"//g')
	for VM in $VMS
	do
		if [[ $(is_vm_running $VM) -eq 1 ]];then
			echo "Stopping VM: $VM..."
			stop_vm $VM
		fi
	done

elif [[ "$1" == "master" ]]; then
	VMS=$(vboxmanage list vms | grep kube-master | awk '{print $1}' | sed -e 's/"//g')
	for VM in $VMS
	do
		if [[ $(is_vm_running $VM) -eq 1 ]];then
			echo "Stopping VM: $VM..."
			stop_vm $VM
		fi
	done
	exit

else
	if [[ $(is_vm_running $1) -eq 1 ]];then
		echo "Stopping VM: $1..."
		stop_vm $1
	else
		echo "VM $1 is not running"
	fi
fi
