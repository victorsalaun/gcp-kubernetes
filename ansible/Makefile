create_virtual_venv:
	python3 -m venv venv

source_venv:
	virtualenv venv

requirements:
	pip3 install -r requirements.txt

configure_namespaces:
	ansible-playbook \
		-e @extra_vars.yaml \
		playbooks/configure_cluster.yaml \
		-t namespace
