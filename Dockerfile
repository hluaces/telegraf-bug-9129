FROM centos:7

COPY files/influxdb.repo /etc/yum.repos.d
RUN yum install -y telegraf \
    && yum clean all

RUN mkdir -p /var/log/apache2 \
    && adduser apache2 \
    && touch /var/log/apache2/error_log \
    && chmod 711 /var/log/apache2/ \
    && chmod 644 /var/log/apache2/error_log \
    && echo "example,result=ok value=1i" >> /var/log/apache2/error_log \
    && echo "example,result=ok value=2i" >> /var/log/apache2/error_log \
    && echo "example,result=ok value=3i" >> /var/log/apache2/error_log \
    && echo "example,result=error value=3i" >> /var/log/apache2/error_log

USER telegraf
COPY files/telegraf.conf /etc/telegraf/telegraf.conf

ENTRYPOINT ["/usr/bin/telegraf", "-config", "/etc/telegraf/telegraf.conf", "-config-directory", "/etc/telegraf/telegraf.d", "--debug", "--test-wait", "10"]
