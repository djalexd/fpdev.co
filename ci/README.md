Read initial Jenkins password
---
* Execute `DOCKER_HOST=tcp://0.0.0.0:2375 docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

Manage ssh connection to cloud VMs
---

Terraform plan creates VMs based on `./cloud/.ssh/key1`, which is
currently not detected by dynamic Ansible inventory. In order to simplify
its usage, the present setup is to add that particular key to the `ssh-agent`
using command `ssh-add ./cloud/.ssh/key1`;


Requirements
---
* *brew*
* VirtualBox (latest version)
* Vagrant 1.8
* Ansible 2.2