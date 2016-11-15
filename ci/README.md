Read initial Jenkins password
---
* Execute `DOCKER_HOST=tcp://0.0.0.0:2375 docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

Requirements
---
* *brew*
* VirtualBox (latest version)
* Vagrant 1.8
* Ansible 2.2