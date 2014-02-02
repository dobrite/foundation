Foundation
==========

So far this will spin up a new droplet (VM) with Digital Ocean. See create.yaml
for parameters of the VM.

Create the environment:
::
    $ make env

while you're at it fill copy and rename local_example.yaml in the group_vars
directory to local.yaml and fill in your details for digital ocean.
::
    $ cp group_vars/local_example.yaml group_vars/local.yaml
    $ <editor> group_vars/local.yaml

Fill out the varibles to the values wanted:
::
    $ cp group_vars/all_example.yaml group_vars/all.yaml
    $ <editor> group_vars/all.yaml

It's assumed that you've sourced both the env-setup from ansible's repo and the
virtualenv:
::
    $ source ansible/hacking/env-setup
    $ source env27/bin/activate

Replace SSH key id(s) in create.yaml with your SSH key id(s) or remove line to not
use and rely on root password (it'll get emailed). dopy expects env vars set
(see below). SSH key ids can be found:
::
    $ ansible/plugins/inventory/digital_ocean.py --ssh-keys

Finally:
::
    $ make one

When it completes you'll get an ID and IP.

You will start getting billed so watch out!

Notes:
======

dopy expects env vars with client id and api key:
::
    $ export DO_CLIENT_ID=<client_id>
    $ export DO_API_KEY=<api_key>

TODO:
=====
* Fail2Ban and/or denyhosts: here_
* use ufw as a front end to iptables
* the blogpost_ here has notes on postgres user dialog and system level users too
* Use system users for cent, app etc.
* paramterize python 3 version python3.{{python_version}} or similar
* convert centrifuge nginx conf into a site.yaml compatible template
* refactor to follow `ansible coding conventions`_.
* maybe use periods to separate tags on hostnames inventory_hostname_short_ will only use up to first dot
* known host_
* centlb nginx site "none" needs fixed
* add var to pg task ports
* add all returned data from instance provisioning to facts.d
* make note about hash merge behaviour in ansible.cfg

.. _conventions: https://github.com/edx/configuration/wiki/Ansible-Coding-Conventions
.. _blogpost: http://michal.karzynski.pl/blog/2013/06/09/django-nginx-gunicorn-virtualenv-supervisor/
.. _here: https://www.digitalocean.com/community/articles/initial-server-setup-with-ubuntu-12-04
.. _short: http://docs.ansible.com/playbooks_variables.html#magic-variables-and-how-to-access-information-about-other-hosts
.. _host: http://www.stavros.io/posts/example-provisioning-and-deployment-ansible/
