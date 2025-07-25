# Build stage
FROM maven:3.6-jdk-8-alpine AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml first to leverage Docker cache
COPY Code/pom.xml .

# Download dependencies
RUN mvn dependency:go-offline -B

# Copy source code
COPY Code/src ./src

# Build application
RUN mvn clean package -DskipTests

# Runtime stage
FROM openjdk:8-jre-alpine

# Install curl for healthcheck
RUN apk add --no-cache curl

# Create non-root user
RUN addgroup -g 1000 spring && \
    adduser -D -s /bin/sh -u 1000 -G spring spring

# Set working directory
WORKDIR /app

# Create upload directory
RUN mkdir -p /app/uploads && chown -R spring:spring /app

# Copy built jar from builder stage
COPY --from=builder /app/target/journals-*.jar app.jar

# Switch to non-root user
USER spring:spring

# Expose port
EXPOSE 8080

# Set JVM options for container environment
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Run application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.jar"]