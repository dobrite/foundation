FROM ubuntu
MAINTAINER dobrite
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y python-yaml python-jinja2 git sudo
RUN git clone https://github.com/ansible/ansible.git /tmp/ansible
WORKDIR /tmp/ansible
ENV PATH /tmp/ansible/bin:/sbin:/usr/sbin:/usr/bin:$PATH
ENV ANSIBLE_LIBRARY /tmp/ansible/library
ENV PYTHONPATH /tmp/ansible/lib:$PYTHON_PATH
RUN git clone https://github.com/dobrite/foundation.git -b packer-testing /tmp/foundation
ADD inventory /etc/ansible/hosts
WORKDIR /tmp/foundation
RUN ansible-playbook redis.yml -c local
EXPOSE 6379
ENTRYPOINT [“/usr/bin/redis-server”]
