# This step is Build
FROM maven:3.5.4-jdk-8-slim AS build
USER root
WORKDIR /app
COPY pom.xml /app/pom.xml
COPY src /app/src
RUN mvn clean package

# This step is RUN
FROM jetty:9.4-jdk8-amazoncorretto
COPY --from=build /app/target/gameoflifeweb.war /var/lib/jetty/webapps/ROOT.war
EXPOSE 9090
CMD ["java", "-jar", "/usr/local/jetty/start.jar"]
