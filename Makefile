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
	ansible all -i 'localhost,' -c local -m vagrant -a "cmd=clear"

vmachine:
	ansible-playbook -i vagrant_inventory site.yml

vcent:
	ansible-playbook -i vagrant_inventory cent_cluster.yml

vapp:
	ansible-playbook -i vagrant_inventory app_cluster.yml

v:
	ansible-playbook -i 'localhost,' vagrant.yml

vall: | v vcent
