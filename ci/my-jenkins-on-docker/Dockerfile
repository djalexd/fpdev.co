FROM jenkins:latest

# initial seed job                  [OK]
COPY scripts/my-pipeline.groovy /usr/share/jenkins/ref/init.groovy.d/my-pipeline.groovy

# Copy the seeds                    [OK]
RUN mkdir /usr/share/jenkins/ref/seed-templates
COPY /seed-templates /usr/share/jenkins/ref/seed-templates

# Add the necessary plugins         [OK]
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

# Add configs
COPY configs/hudson.tasks.Maven.xml /var/jenkins_home/hudson.tasks.Maven.xml
COPY configs/hudson.plugins.gradle.Gradle.xml /var/jenkins_home/hudson.plugins.gradle.Gradle.xml

# Add the google auth configuration

# lets encrypt certificate for jenkins.fpdev.co
# create environment from Jenkins (terraform)
# how to deploy to environment?

# - local development + deployment.
# custom Dockerfile                 [ok]
# add necessary plugins             [ok]
# disable startup password          [?]

# add the necessary plugins         [ok]
# add maven3 tool                   [ok]
# create enviroment from jenkins    [?]


# cloud development + deployment.