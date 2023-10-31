# 1. BUILD stage
FROM maven:3.5.4-jdk-8-slim AS build
RUN groupadd -r jetty && useradd -r -g jetty jetty
WORKDIR /app
COPY pom.xml /app/pom.xml
COPY gameoflife-acceptance-tests/ /app/gameoflife-acceptance-tests/
COPY gameoflife-build/ /app/gameoflife-build/
COPY gameoflife-core/ /app/gameoflife-core/
COPY gameoflife-deploy/ /app/gameoflife-deploy/
COPY gameoflife-web/ /app/gameoflife-web/
RUN mvn clean package
RUN chown jetty:jetty /app/gameoflife-web/target/gameoflife.war

# 2. RUN Stage
FROM jetty:9.4-jdk8
USER jetty
COPY --from=build /app/gameoflife-web/target/gameoflife.war /var/lib/jetty/webapps/ROOT.war
EXPOSE 8080
CMD ["/bin/sh", "-ec", "while :; do echo 'Hello SONGGK'; sleep 5 ; done"]
# CMD ["java", "-jar", "/usr/local/jetty/start.jar"]
