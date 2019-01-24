FROM azul/zulu-openjdk-alpine:11 as packager

RUN { \
        java --version ; \
        echo "jlink version:" && \
        jlink --version ; \
    }

ENV JAVA_MINIMAL=/opt/jre

# build modules distribution
RUN jlink \
    --verbose \
    --add-modules \
        java.base,java.compiler,java.datatransfer,java.desktop,java.instrument,java.logging,java.management,java.management.rmi,java.naming,java.net.http,java.prefs,java.rmi,java.scripting,java.se,java.security.jgss,java.security.sasl,java.smartcardio,java.sql,java.sql.rowset,java.transaction.xa,java.xml,java.xml.crypto \
#        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
        # java.naming - javax/naming/NamingException
        # java.desktop - java/beans/PropertyEditorSupport
        # java.management - javax/management/MBeanServer
        # java.security.jgss - org/ietf/jgss/GSSException
        # java.instrument - java/lang/instrument/IllegalClassFormatException
    --compress 2 \
    --strip-debug \
    --no-header-files \
    --no-man-pages \
    --output "$JAVA_MINIMAL"

# Second stage, add only our minimal "JRE" distr and our app
FROM alpine:3.8

ENV JAVA_MINIMAL=/opt/jre
ENV JAVA_HOME=$JAVA_MINIMAL
ENV PATH="$PATH:$JAVA_MINIMAL/bin"
ARG VERSION=$VERSION
ENV KM_UTILS_VERSION 0.4.3
ENV B_LOG_VERSION 0.4.3

COPY --from=packager "$JAVA_MINIMAL" "$JAVA_MINIMAL"
ADD http://sodio.stratio.com/repository/paas/kms_utils/${KM_UTILS_VERSION}/kms_utils-${KM_UTILS_VERSION}.sh /data/stratio/kms_utils.sh
ADD http://sodio.stratio.com/repository/paas/log_utils/${B_LOG_VERSION}/b-log-${B_LOG_VERSION}.sh /data/stratio/b-log.sh
RUN apk add curl bash jq openssl
WORKDIR /data

CMD ["/bin/bash"]