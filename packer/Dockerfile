FROM ubuntu
MAINTAINER yourname
RUN apt-get -y update
RUN apt-get install -y python-yaml python-jinja2 git
RUN git clone http://github.com/ansible/ansible.git /tmp/ansible
WORKDIR /tmp/ansible
ENV PATH /tmp/ansible/bin:/sbin:/usr/sbin:/usr/bin
ENV ANSIBLE_LIBRARY /tmp/ansible/library
ENV PYTHONPATH /tmp/ansible/lib:$PYTHON_PATH
RUN git clone http://github.com/dobrite/foundation.git -b packer-testing /tmp/foundation
ADD inventory /etc/ansible/hosts
WORKDIR /tmp/foundation
RUN ansible-playbook redis.yml -c local
EXPOSE 22 6395
ENTRYPOINT [“/usr/bin/foo”]
