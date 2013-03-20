#!/bin/bash
#VBoxManage startvm <vm> --type headless
#Script para inicializar maquinas virtuais em background criadas com VirtualBox (www.virtualbox.org)

### To Do ###
# - quando utilizar o modo single (inicializar apenas uma vm) verificar se o nome passado por parametro
# é um nome de vm válido
# - quando utilizar o modo multi (inicializar todas as vms) verificar se existe ao menos uma vm dentro 
# do array de vm e se esses nomes são válidos
# - tentar recuperar ou setar o ip da vm
#############


# stop ou start
command=$1

# nome da vm, se não for passado e o array de vms estiver correto irá inicialiar todas vms do array
# se array estiver incorreto, ver To Do
single=$2

#array de vms caso opte por inicializacao de todas
#vms=(CentOS-App CentOS-Db CentOS-Slony)

function error() {
    echo
    echo "Usar: inicializa-vms <start|stop> [vm_name]"
    echo
}

if [ -n "$command" ]
then
	if [ -z "$single" ]
	then
		for i in $(seq 3)
		do 
			if [ "$command" = "start" ]
			then
				echo "Starting ${vms[$((i-1))]}"
				VBoxManage startvm ${vms[$((i-1))]} --type headless; 
			elif [ "$command" = "stop" ]
			then
				echo "Stopping ${vms[$((i-1))]}"
				VBoxManage controlvm ${vms[$((i-1))]} acpipowerbutton;
			else
				error
				exit 0;
			fi
		done
	else 
		if [ "$command" = "start" ]
		then
			echo "Starting $single"
			VBoxManage startvm $single --type headless;
		elif [ "$command" = "stop" ]
		then
			echo "Stopping $single"
			VBoxManage controlvm $single acpipowerbutton;
		else
			error
		fi
	fi
else
	error
fi

exit 0;
