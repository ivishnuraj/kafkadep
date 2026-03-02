FROM apache/kafka:3.7.0

USER root

# Copy configs
COPY server.properties /etc/kafka/server.properties
COPY jaas.conf /etc/kafka/jaas.conf
COPY ssl/ /etc/kafka/ssl/

# Fix permissions
RUN chmod -R 644 /etc/kafka/ssl/*

USER appuser

CMD ["bash", "-c", " \
  export KAFKA_OPTS='-Djava.security.auth.login.config=/etc/kafka/jaas.conf' && \
  if [ ! -f /var/lib/kafka/data/meta.properties ]; then \
    /opt/kafka/bin/kafka-storage.sh format -t $(/opt/kafka/bin/kafka-storage.sh random-uuid) -c /etc/kafka/server.properties; \
  fi && \
  /opt/kafka/bin/kafka-server-start.sh /etc/kafka/server.properties \
"]