FROM alpine:3.6

RUN apk update && \
  apk upgrade && \
  apk add openjdk8=8.131.11-r0 && \
  rm -rf /var/cache/apk/* && \
  echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/default-jvm/jre/lib/security/java.security && \
  mkdir /data


WORKDIR /data

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

CMD ["sh"]