#
# Build stage
#
FROM eclipse-temurin:11-jdk AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM eclipse-temurin
COPY --from=build /home/app/target/my-app-1.0-SNAPSHOT.jar /usr/local/lib/my-app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/my-app.jar"]