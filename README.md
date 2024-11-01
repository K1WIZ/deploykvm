# deploykvm
This is an ansible playbook to clone multiple KVM guests from a template KVM vm


Example Usage:

ansible-playbook deploykvm.yaml --extra-vars "vm_count=3 network_bridge=br10 vcpu=4 memory=4096 base_ip=10.9.9.210 mask=24"
