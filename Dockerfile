# Dockerfile
FROM openjdk:11-jre-slim
WORKDIR /app
COPY calculator.jar calculator.jar
ENTRYPOINT ["java", "-jar", "calculator.jar"]

