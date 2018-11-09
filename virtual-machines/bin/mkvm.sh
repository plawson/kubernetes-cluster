#/bin/bash

function usage {
	echo "$0: [-h] | --name VM_NAME --user USERNAME [--mac MAC_ADDRESS] [--cpu #_CPU]"
	exit
}

function generate_iso {
	# Parameters: $1 VM name, $2 vm owner
	if [[ $# -ne 2 ]]; then
		echo ""
		echo "ERROR: generate_iso wrong number of parameters ($#): $@"
		echo ""
		exit
	fi
	VM_NAME=$1
	VM_OWNER=$2
	THE_DIR=$(dirname $0)

	if [[ ${USER} != "root" ]]; then
		echo ""
		echo "ERROR: Script must be run as root"
		echo ""
	fi

	# Set host name
	cp -f $THE_DIR/../unattended_iso_customization/ks.preseed /opt/ubuntuiso/ks.preseed
	sed -r -i 's@^d-i netcfg/get_hostname string.*$@d-i netcfg/get_hostname string\t\t'${VM_NAME}'@' /opt/ubuntuiso/ks.preseed
	# Customize post install script
	cp -f $THE_DIR/../unattended_iso_customization/post-install.sh /opt/ubuntuiso/post-install.sh
	chmod 755 /opt/ubuntuiso/post-install.sh
	sed -r -i 's@^new_hostname.*$@new_hostname="'${VM_NAME}'"@' /opt/ubuntuiso/post-install.sh
	# Docker customization
	cp -f $THE_DIR/../unattended_iso_customization/custdocker /opt/ubuntuiso/custdocker
	cp -f $THE_DIR/../unattended_iso_customization/daemon.json /opt/ubuntuiso/daemon.json
	sed -r -i 's@your_local_insecure_registry@192\.168\.1\.101:5000@' /opt/ubuntuiso/daemon.json
	# Copy hosts file customization
	cp -f $THE_DIR/../unattended_iso_customization/vm_hosts /opt/ubuntuiso/vm_hosts
	# Copy sudoers
	cp -f $THE_DIR/../unattended_iso_customization/k8s /opt/ubuntuiso/k8s

	# Generate iso
	rm -f /home/$VM_OWNER/virtual_machines/my_iso/ubuntu-16.04.3-server-amd64-silent_$VM_NAME.iso
	mkisofs -D -r -V "ATTENDLESS_UBUNTU" -cache-inodes -J -l -b isolinux/isolinux.bin \
		-c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table \
		-o /home/$VM_OWNER/virtual_machines/my_iso/ubuntu-16.04.3-server-amd64-silent_$VM_NAME.iso /opt/ubuntuiso
}

function create_vm {
	# Parameters: $1 VM name, $2 vm owner
        if [[ $# -lt 2 ]]; then
                echo ""
                echo "ERROR: generate_iso wrong number of parameters ($#): $@"
                echo ""
                exit
        fi
        VM_NAME=$1
        VM_OWNER=$2
	VM_CPU=${3:-3}
	MAC_ADDRESS=$4

	if [[ ! -f /home/$VM_OWNER/virtual_machines/my_iso/ubuntu-16.04.3-server-amd64-silent_$VM_NAME.iso ]]; then
		echo ""
		echo "ISO /home/$VM_OWNER/virtual_machines/my_iso/ubuntu-16.04.3-server-amd64-silent_$VM_NAME.iso does't exist, please run script as root for iso to be generated"
		echo ""
		exit
	fi

	if [[ ${USER} != "$VM_OWNER" ]]; then
                echo ""
                echo "ERROR: Script must be run as $VM_OWNER"
                echo ""
        fi

	vboxmanage createvm --name $VM_NAME --basefolder /home/$VM_OWNER/virtual_machines --register
	vboxmanage modifyvm $VM_NAME --ostype Ubuntu_64
	vboxmanage modifyvm $VM_NAME --memory 31744
	vboxmanage modifyvm $VM_NAME --acpi on
	vboxmanage modifyvm $VM_NAME --ioapic on
	vboxmanage modifyvm $VM_NAME --cpus ${VM_CPU}
	vboxmanage modifyvm $VM_NAME --nic1 bridged --bridgeadapter1 enp5s0    
	if [[ ! -z "${MAC_ADDRESS}" ]]; then
		vboxmanage modifyvm $VM_NAME --macaddress1 $MAC_ADDRESS
	fi
	vboxmanage createhd --filename /synology/vm/virtualbox/$VM_NAME -size 1097152 --variant Standard --format VDI
	vboxmanage storagectl $VM_NAME --name "SATA Controller" --add sata --bootable on
	vboxmanage storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /synology/vm/virtualbox/$VM_NAME.vdi
	vboxmanage storagectl $VM_NAME --name "IDE Controller" --add ide
	vboxmanage storageattach $VM_NAME --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium /home/$VM_OWNER/virtual_machines/my_iso/ubuntu-16.04.3-server-amd64-silent_$VM_NAME.iso
	vboxmanage startvm $VM_NAME --type headless
	# Comment the previousline and uncomment the below command when debugging your unattended iso install.
	# Note that uncommenting the below line will display the X11 install UI. In that case set your $DISPLAY variable accordingly before running the script or the istall might hang.
	#vboxmanage startvm $VM_NAME
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
	key="$1"
	case $key in
		--name)
		VM_NAME="$2"
		shift # past argument
		shift # past value
		;;
		--user)
		VM_OWNER="$2"
		shift # past argument
		shift # past value
		;;
		--mac)
		MAC_ADDRESS="$2"
		shift # past argument
		shift # past value
		;;
		--cpu)
		VM_CPU="$2"
		shift # past argument
		shift # past value
		;;
		-h)
		usage
		;;
		*) # unknown option
		POSITIONAL+=("$1") # save it in an array for later
		shift # past argument
		;;
	esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -z "${VM_NAME// }" ]]; then
	usage
fi

if [[ -z "${VM_OWNER// }" ]]; then
	usage
fi

if [[ -z "${MAC_ADDRESS// }" ]]; then
	MAC_ADDRESS=""
fi

if [[ -z "${VM_CPU// }" ]]; then
	VM_CPU=""
fi


if [[ ${USER} == "root" ]]; then
	generate_iso $VM_NAME $VM_OWNER
	sudo -u $VM_OWNER /bin/bash $0 --name $VM_NAME --user $VM_OWNER --mac $MAC_ADDRESS --cpu $VM_CPU
else
	create_vm $VM_NAME $VM_OWNER $VM_CPU $MAC_ADDRESS
fi
