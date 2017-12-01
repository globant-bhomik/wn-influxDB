FROM openjdk:8-jdk

ENV INFLUXDB_VERSION 1.2.2
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN cd /var &&\
	mkdir -p -v database &&\
	cd /var/database &&\
	wget -q https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}_linux_i386.tar.gz && \
    tar xvfz influxdb-${INFLUXDB_VERSION}_linux_i386.tar.gz && \
	rm -rf /var/database/influxdb-${INFLUXDB_VERSION}-1/etc/influxdb.conf &&\
	rm -rf *.tar.gz &&\
	chmod +x /var/database/influxdb-${INFLUXDB_VERSION}-1/usr/bin/*
    
COPY influxdb.conf /etc/influxdb/influxdb.conf
ENV PATH "/var/database/influxdb-${INFLUXDB_VERSION}-1/usr/bin/:${PATH}"
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
CMD ["/entrypoint.sh"]