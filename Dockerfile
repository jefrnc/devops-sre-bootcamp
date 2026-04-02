# Build stage
FROM maven:3.8-eclipse-temurin-8 AS builder

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
FROM eclipse-temurin:8-jre

# Install curl for healthcheck
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -s /bin/bash spring

# Set working directory
WORKDIR /app

# Create upload directory
RUN mkdir -p /app/uploads && chown -R spring:spring /app

# Copy built jar from builder stage
COPY --from=builder /app/target/journals-*.jar app.jar

# Switch to non-root user
USER spring

# Expose port
EXPOSE 8080

# Set JVM options for container environment
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Run application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.jar"]