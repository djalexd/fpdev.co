FROM nginx

ENV CT_VERSION   '0.16.0'
ENV CONSUL       '127.0.0.1:8500'
# Empty default value
ENV CONSUL_TOKEN ''

RUN apt-get update -y && \
    apt-get install -y wget unzip && \
    wget https://releases.hashicorp.com/consul-template/${CT_VERSION}/consul-template_${CT_VERSION}_linux_amd64.zip -q --output-document=/tmp/consul-template.zip && \
    unzip /tmp/consul-template -d /usr/sbin
    
RUN mkdir /templates
ADD nginx.cfg.template /templates/nginx.cfg.template
ADD consul.conf /etc/consul.conf

CMD ["consul-template", "-config=", "/etc/consul.conf", " && ", "nginx", "-g", "daemon off;"]