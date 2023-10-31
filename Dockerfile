# 1. BUILD stage
FROM maven:3.5.4-jdk-8-slim AS build
USER root
WORKDIR /app
COPY pom.xml /app/pom.xml
COPY src /app/src
RUN mvn clean package

# 2. RUN Stage
FROM jetty:9.4-jdk8-amazoncorretto
COPY --from=build /app/gameoflife-web/target/gameoflifeweb.war /var/lib/jetty/webapps/ROOT.war
EXPOSE 9090
ENTRYPOINT ["java", "-jar", "/usr/local/jetty/start.jar"]