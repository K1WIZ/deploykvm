#!/bin/bash
#
# This script is a simple tool to rapidly destroy and cleanup KVM guest VMs.
# John Rogers   08-10-2024
#
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <basename> <serial_range>"
  echo "Example: $0 vmguest 01-07"
  exit 1
fi

BASENAME=$1
RANGE=$2
START=${RANGE%-*}
END=${RANGE#*-}

for i in $(seq -f "%02g" "$START" "$END"); do
  VM_NAME="${BASENAME}${i}"
  
  if virsh dominfo "$VM_NAME" > /dev/null 2>&1; then
    echo "Destroying and undefining $VM_NAME..."
    virsh destroy "$VM_NAME" 2>/dev/null
    virsh undefine "$VM_NAME" --remove-all-storage
    echo "$VM_NAME destroyed and storage removed."
  else
    echo "$VM_NAME does not exist."
  fi
done
