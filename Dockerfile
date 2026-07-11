# Multi-stage production Docker image (optional — Render native Java is preferred)
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY .mvn .mvn
COPY mvnw .
RUN chmod +x mvnw && ./mvnw clean package -DskipTests -B

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
RUN addgroup -S infralytix && adduser -S infralytix -G infralytix
USER infralytix
COPY --from=build /app/target/infralytix-technologies.jar app.jar
ENV SPRING_PROFILES_ACTIVE=prod
ENV JAVA_TOOL_OPTIONS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD wget -qO- http://localhost:${PORT:-8080}/actuator/health || exit 1
ENTRYPOINT ["java", "-jar", "app.jar"]
