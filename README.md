# DevOps/SRE Bootcamp - From Code to Production

A complete hands-on bootcamp to fast-track your journey into DevOps/SRE. Uses a Spring Boot application (Journal Management System) as the vehicle to learn infrastructure automation, containerization, CI/CD pipelines, and GitOps — all in a structured, task-based path.

## What You'll Learn

| Task | Skill | Tools |
|---|---|---|
| 1 | Infrastructure as Code | Terraform, Azure |
| 2 | Configuration Management | Ansible |
| 3 | Application Deployment | Spring Boot, Maven, MySQL |
| 4 | Artifact Management | Nexus |
| 5 | Containerization | Docker |
| 6 | Image Registry | Docker Hub / Nexus |
| 7 | CI Pipeline | Jenkins |
| 8 | CD Pipeline | Jenkins |
| 9 | GitOps | Kubernetes manifests, multi-env |

## Quick Start

### Prerequisites

- Java 8
- Maven 3.3+
- MySQL 5.6+
- Docker (optional)

### Run Locally

```bash
git clone https://github.com/jefrnc/semperti-bootcamp-sre.git
cd semperti-bootcamp-sre/Code
# Edit src/main/resources/application.properties with your MySQL config
mvn clean install
mvn spring-boot:run
```

Access at http://localhost:8080

### Run with Docker

```bash
docker build -t journals-app:latest .
docker run -d -p 8080:8080 \
  -e MYSQL_HOST=mysql \
  -e MYSQL_USER=root \
  -e MYSQL_PASSWORD=password \
  journals-app:latest
```

Or use Docker Compose:

```bash
docker-compose up -d
```

## Default Credentials

| Role | Username | Password |
|---|---|---|
| Publisher (read/write) | publisher1 | publisher1 |
| Publisher (read/write) | publisher2 | publisher2 |
| User (read only) | user1 | user1 |
| User (read only) | user2 | user2 |

## Application Architecture

- **Backend:** Spring Boot 1.3.3 + Spring Security
- **Frontend:** Thymeleaf + AngularJS
- **Database:** MySQL 5.6+
- **Build:** Maven
- **CI/CD:** Jenkinsfile included

```
Code/
├── pom.xml
└── src/
    ├── main/
    │   ├── java/.../journals/
    │   │   ├── config/        # Spring config
    │   │   ├── controller/    # MVC controllers
    │   │   ├── model/         # JPA entities
    │   │   ├── repository/    # Data access
    │   │   ├── rest/          # REST APIs
    │   │   └── service/       # Business logic
    │   └── resources/
    │       ├── static/        # CSS, JS
    │       └── templates/     # Thymeleaf views
    └── test/                  # Unit tests
```

## Testing

```bash
mvn test                                    # Run all tests
mvn test -Dtest=CategoryRestServiceTest     # Run specific test
mvn jacoco:report                           # Coverage report
```

## Environment Variables

| Variable | Default | Description |
|---|---|---|
| `MYSQL_HOST` | localhost | MySQL host |
| `MYSQL_PORT` | 3306 | MySQL port |
| `MYSQL_DATABASE` | journals | Database name |
| `MYSQL_USER` | - | MySQL username |
| `MYSQL_PASSWORD` | - | MySQL password |
| `UPLOAD_DIR` | ~/upload | PDF storage directory |

## Bootcamp Tasks Detail

### Task 1: Create VM with Terraform
Provision a CentOS 7 VM in Azure (max 2 cores, 2GB RAM) accessible via VPN.

### Task 2: Configure VM with Ansible
Automate server setup: Java 8, Maven, MySQL, and all dependencies.

### Task 3: Deploy the Application
Get the app running end-to-end: create journals, upload PDFs, pass all Maven tests.

### Task 4: Nexus Artifact Management
Upload snapshot and release artifacts to Nexus using Ansible scripts.

### Task 5: Dockerize the Application
Create an optimized Dockerfile, run the app in a container.

### Task 6: Push to Image Registry
Push Docker images to Docker Hub/Nexus with a logical tagging strategy.

### Task 7: CI Pipeline
Jenkins pipeline triggered on PRs with stages: build, test, package, upload to Nexus.

### Task 8: CD Pipeline
Automated deployment pipeline with health checks and rollback capability.

### Task 9: GitOps
Kubernetes manifests in Git, multi-environment (staging/prod), commit-driven deploys.

## Who Is This For?

- Developers transitioning into DevOps/SRE roles
- Junior DevOps engineers looking for a structured learning path
- Teams onboarding new members into infrastructure practices

## License

MIT

---

## Support this project

Free, and maintained on my own time. If it saved you a weekend of work, you can
[sponsor me on GitHub](https://github.com/sponsors/jefrnc).

[![Sponsor](https://img.shields.io/badge/Sponsor-jefrnc-EA4AAA?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/jefrnc)
