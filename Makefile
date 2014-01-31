.PHONY: clean

env:
	virtualenv env27
	git clone git@github.com:ansible/ansible.git
	git clone git@github.com:dobrite/ansible-vagrant.git
	env27/bin/pip install pyyaml jinja2 dopy python-vagrant
	ln -s $(shell pwd)/ansible-vagrant/library/vagrant $(shell pwd)/ansible/library/cloud/vagrant

clean:
	rm -rf bin/ include/ lib/ .installed.cfg .mr.developer.cfg develop-eggs/ eggs/ parts/ src/ node_modules/ app/bower_components/ __pycache__/ .cache/ env27/ ansible/ ansible-vagrant/

do:
	ansible-playbook -i hosts --limit local create_do.yml

bootstrap:
	ansible-playbook -i ansible/plugins/inventory/digital_ocean.py -t bootstrap site.yml

machine:
	ansible-playbook -i ansible/plugins/inventory/digital_ocean.py site.yml

vclean:
	ansible all -i hosts -c local -m vagrant -a "cmd=clear"

vmachine:
	ansible-playbook -i vagrant_inventory site.yml --skip-tags=bootstrap,ssh_setup

v:
	ansible-playbook -i hosts vagrant.yml
	ansible-playbook -i vagrant_inventory site.yml --tags=bootstrap -e ansible_ssh_port=22 -u vagrant -e gather_facts=false
	ansible-playbook -i vagrant_inventory site.yml --tags=ssh_setup -e ansible_ssh_port=22 --skip-tags=bootstrap -e gather_facts=false

vall: | v vmachine
