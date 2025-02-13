FROM amazoncorretto:8 

RUN mkdir -p /tron/output-directory/database; yum -y install gettext
ADD ./files/FullNode.jar /tron/
ADD ./files/sr.conf.template /tron/sr.conf.template
ADD ./files/logback.xml /tron/logback.xml
ADD ./files/docker-entrypoint.sh /docker-entrypoint.sh
ADD ./files/database/ /tron/output-directory/database/
RUN chmod +x ./docker-entrypoint.sh

WORKDIR "/tron"
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-jar", "/tron/FullNode.jar", "--witness", "-c", "/tron/sr.conf", "--log-config", "/tron/logback.xml"]
