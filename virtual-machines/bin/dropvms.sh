#/bin/bash

if [[ $# -ne 1 ]]; then
        echo "usage: $0 all|nodes|master|<VM_NAME>"
        exit
fi

THE_DIR=$(dirname $0)

if [[ "$1" == "all" ]]; then
	$THE_DIR/stopvms.sh all
        VMS=$(vboxmanage list vms | awk '{print $1}' | sed -e 's/"//g')
        for VM in $VMS
        do
		echo "Dropping VM: $VM..."
                vboxmanage unregistervm $VM --delete
        done

elif [[ "$1" == "nodes" ]]; then
	$THE_DIR/stopvms.sh nodes
        VMS=$(vboxmanage list vms | grep kube-node | awk '{print $1}' | sed -e 's/"//g')
        for VM in $VMS
        do
		echo "Dropping VM: $VM..."
                vboxmanage unregistervm $VM --delete
        done

elif [[ "$1" == "master" ]]; then
	$THE_DIR/stopvms.sh master
        VMS=$(vboxmanage list vms | grep kube-master | awk '{print $1}' | sed -e 's/"//g')
        for VM in $VMS
        do
		echo "Dropping VM: $VM..."
                vboxmanage unregistervm $VM --delete
        done

else
	$THE_DIR/stopvms.sh $1
	echo "Dropping VM: $1..."
	vboxmanage unregistervm $1 --delete
fi
