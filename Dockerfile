FROM openjdk:8-jdk

ENV INFLUXDB_VERSION 1.2.2
RUN apt-get update && apt-get install -y git curl wget sudo dpkg && rm -rf /var/lib/apt/lists/*
RUN cd /var &&\
	mkdir -p -v database &&\
	cd /var/database &&\
	wget -q https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}_linux_i386.tar.gz && \
    tar xvfz influxdb-${INFLUXDB_VERSION}_linux_i386.tar.gz && \
	rm -rf /var/database/influxdb-${INFLUXDB_VERSION}-1/etc/influxdb.conf &&\
	rm -rf *.tar.gz &&\
	ls -lart /var/database/influxdb-${INFLUXDB_VERSION}-1/usr/bin/ &&\
	chmod +x /var/database/influxdb-${INFLUXDB_VERSION}-1/usr/bin/*
    
#COPY influxdb.conf /var/database/influxdb-${INFLUXDB_VERSION}-1/usr/bin
COPY influxdb.conf /etc/influxdb/influxdb.conf


#EXPOSE 8086
#EXPOSE 8083
#EXPOSE 2003
#VOLUME /var/lib/influxdb

ENV PATH "/var/database/influxdb-${INFLUXDB_VERSION}-1/usr/bin/:${PATH}"
RUN printenv | more

#RUN influxd -config /var/database/influxdb-${INFLUXDB_VERSION}-1/usr/bin/influxdb.conf
#RUN influxd

COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
#ENTRYPOINT influxd
#CMD "influxd"