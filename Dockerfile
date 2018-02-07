FROM alpine:3.6

ARG VERSION=$VERSION
ENV CONSUL_TEMPLATE_VERSION 0.19.4
ENV KM_UTILS_VERSION 0.4.0
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV B_LOG_VERSION 0.4.0


ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /data/
ADD http://sodio.stratio.com/repository/paas/kms_utils/${KM_UTILS_VERSION}/kms_utils-${KM_UTILS_VERSION}.sh /opt/stratio/stratio-kms/kms_utils.sh
ADD http://sodio.stratio.com/repository/paas/log_utils/${B_LOG_VERSION}/b-log-${B_LOG_VERSION}.sh /opt/stratio/stratio-kms/b-log.sh

RUN apk --update --upgrade add openjdk8 curl bash jq openssl && \
    rm -rf /var/cache/apk/* && \
    echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/default-jvm/jre/lib/security/java.security && \
    cd /data && \
    unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /bin/consul-template && \
    rm consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip


WORKDIR /data


CMD ["/bin/bash"]
