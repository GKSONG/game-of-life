# 1. BUILD stage
FROM maven:3.5.4-jdk-8-slim AS build
WORKDIR /app
COPY pom.xml /app/pom.xml
COPY gameoflife-acceptance-tests/ /app/gameoflife-acceptance-tests/
COPY gameoflife-build/ /app/gameoflife-build/
COPY gameoflife-core/ /app/gameoflife-core/
COPY gameoflife-deploy/ /app/gameoflife-deploy/
COPY gameoflife-web/ /app/gameoflife-web/
RUN mvn clean package

# 2. RUN Stage
FROM jetty:9.4-jdk8
COPY --from=build /app/gameoflife-web/target/gameoflife.war /var/lib/jetty/webapps/ROOT.war
EXPOSE 8080
CMD ["/bin/sh", "-ec", "while :; do echo 'Hello SONGGK'; sleep 5 ; done"]
# CMD ["java", "-jar", "/usr/local/jetty/start.jar"]
