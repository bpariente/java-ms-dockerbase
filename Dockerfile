FROM alpine:3.8

ARG VERSION=$VERSION
ENV CONFD_VERSION 0.15.0
ENV KM_UTILS_VERSION 0.4.2
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV B_LOG_VERSION 0.4.2


ADD https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 /data/confd/confd
#ADD http://sodio.stratio.com/repository/paas/kms_utils/${KM_UTILS_VERSION}/kms_utils-${KM_UTILS_VERSION}.sh /opt/stratio/stratio-kms/kms_utils.sh
ADD http://sodio.stratio.com/repository/paas/log_utils/${B_LOG_VERSION}/b-log-${B_LOG_VERSION}.sh /opt/stratio/stratio-kms/b-log.sh
ADD lib/kms_utils.sh /opt/stratio/stratio-kms/kms_utils.sh

RUN apk --update --upgrade add openjdk8 curl bash jq openssl && \
    rm -rf /var/cache/apk/* && \
    echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/default-jvm/jre/lib/security/java.security && \
    cd /data && \
    chmod +x confd/confd

WORKDIR /data

CMD ["/bin/bash"]