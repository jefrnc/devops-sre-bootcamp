# Troubleshooting Guide

This guide covers common issues encountered during the bootcamp and their solutions.

## 🔧 Common Issues

### Application Issues

#### MySQL Connection Failed
**Error:** `Communications link failure`

**Solutions:**
1. Check MySQL is running:
   ```bash
   systemctl status mysql
   # or
   docker ps | grep mysql
   ```

2. Verify connection settings:
   ```bash
   mysql -h localhost -u root -p
   ```

3. Check application.properties:
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/journals?createDatabaseIfNotExist=true
   spring.datasource.username=root
   spring.datasource.password=yourpassword
   ```

#### Port 8080 Already in Use
**Error:** `Port 8080 is already in use`

**Solutions:**
1. Find process using port:
   ```bash
   lsof -i :8080
   # or
   netstat -tulpn | grep 8080
   ```

2. Kill the process:
   ```bash
   kill -9 <PID>
   ```

3. Or change application port:
   ```properties
   server.port=8081
   ```

#### Maven Build Failures
**Error:** `Could not resolve dependencies`

**Solutions:**
1. Clean Maven cache:
   ```bash
   mvn clean
   rm -rf ~/.m2/repository
   mvn install
   ```

2. Check internet connectivity:
   ```bash
   ping repo1.maven.org
   ```

3. Use Maven wrapper:
   ```bash
   ./mvnw clean install
   ```

### Docker Issues

#### Docker Build Fails
**Error:** `Cannot connect to Docker daemon`

**Solutions:**
1. Check Docker service:
   ```bash
   systemctl status docker
   # or
   docker info
   ```

2. Add user to docker group:
   ```bash
   sudo usermod -aG docker $USER
   newgrp docker
   ```

3. Restart Docker:
   ```bash
   sudo systemctl restart docker
   ```

#### Container Won't Start
**Error:** `Container exits immediately`

**Solutions:**
1. Check logs:
   ```bash
   docker logs <container-name>
   ```

2. Run interactively:
   ```bash
   docker run -it <image> /bin/sh
   ```

3. Check health status:
   ```bash
   docker inspect <container> | grep -i health
   ```

### Terraform Issues

#### Provider Not Found
**Error:** `Provider "azurerm" not available`

**Solutions:**
1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Update providers:
   ```bash
   terraform init -upgrade
   ```

3. Check provider version:
   ```hcl
   terraform {
     required_providers {
       azurerm = {
         source  = "hashicorp/azurerm"
         version = "~> 3.0"
       }
     }
   }
   ```

#### Resource Already Exists
**Error:** `Resource already exists`

**Solutions:**
1. Import existing resource:
   ```bash
   terraform import azurerm_resource_group.example /subscriptions/.../resourceGroups/mygroup
   ```

2. Or destroy and recreate:
   ```bash
   terraform destroy -target=azurerm_resource_group.example
   terraform apply
   ```

### Ansible Issues

#### SSH Connection Failed
**Error:** `Failed to connect to host via ssh`

**Solutions:**
1. Test SSH manually:
   ```bash
   ssh -i ~/.ssh/id_rsa user@host
   ```

2. Check inventory file:
   ```ini
   [webservers]
   server1 ansible_host=10.0.0.1 ansible_user=centos ansible_ssh_private_key_file=~/.ssh/id_rsa
   ```

3. Disable host key checking:
   ```bash
   export ANSIBLE_HOST_KEY_CHECKING=False
   ```

#### Playbook Syntax Error
**Error:** `ERROR! Syntax Error while loading YAML`

**Solutions:**
1. Validate YAML:
   ```bash
   ansible-playbook --syntax-check playbook.yml
   ```

2. Use YAML linter:
   ```bash
   yamllint playbook.yml
   ```

3. Check indentation (spaces, not tabs)

### Jenkins Issues

#### Build Stuck in Queue
**Problem:** Build won't start

**Solutions:**
1. Check available executors
2. Verify slave is online
3. Check disk space:
   ```bash
   df -h
   ```

#### Pipeline Script Error
**Error:** `WorkflowScript: Expected a step`

**Solutions:**
1. Validate Jenkinsfile syntax
2. Check for missing closing braces
3. Ensure proper stage structure:
   ```groovy
   stage('Name') {
       steps {
           sh 'command'
       }
   }
   ```

### Git Issues

#### Permission Denied (publickey)
**Error:** `Permission denied (publickey)`

**Solutions:**
1. Add SSH key to agent:
   ```bash
   ssh-add ~/.ssh/id_rsa
   ```

2. Check SSH config:
   ```bash
   cat ~/.ssh/config
   ```

3. Test GitHub connection:
   ```bash
   ssh -T git@github.com
   ```

#### Merge Conflicts
**Problem:** Cannot merge branches

**Solutions:**
1. Update local branch:
   ```bash
   git fetch origin
   git rebase origin/master
   ```

2. Resolve conflicts manually:
   ```bash
   git status
   # Edit conflicted files
   git add .
   git rebase --continue
   ```

## 🚨 Emergency Procedures

### Application Down
1. Check application logs:
   ```bash
   docker logs journals-app
   # or
   tail -f logs/application.log
   ```

2. Restart services:
   ```bash
   docker-compose restart
   # or
   systemctl restart journals
   ```

3. Check database:
   ```bash
   mysql -u root -p -e "SHOW DATABASES;"
   ```

### Data Loss
1. Check backups:
   ```bash
   ls -la /backup/mysql/
   ```

2. Restore from backup:
   ```bash
   mysql -u root -p journals < backup.sql
   ```

### Security Breach
1. Isolate affected systems
2. Change all passwords
3. Review access logs
4. Notify team lead immediately

## 📊 Performance Issues

### Slow Application
1. Check system resources:
   ```bash
   top
   htop
   free -m
   ```

2. Monitor database:
   ```sql
   SHOW PROCESSLIST;
   SHOW ENGINE INNODB STATUS;
   ```

3. Check Java heap:
   ```bash
   jmap -heap <PID>
   ```

### High Memory Usage
1. Analyze heap dump:
   ```bash
   jmap -dump:format=b,file=heap.bin <PID>
   ```

2. Adjust JVM settings:
   ```bash
   java -Xmx1g -Xms512m -jar app.jar
   ```

## 🔍 Debugging Tips

### Enable Debug Logging
1. In application.properties:
   ```properties
   logging.level.root=DEBUG
   logging.level.com.semperti=DEBUG
   ```

2. For SQL queries:
   ```properties
   spring.jpa.show-sql=true
   hibernate.format_sql=true
   ```

### Remote Debugging
1. Start with debug options:
   ```bash
   java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar app.jar
   ```

2. Connect IDE to port 5005

### Docker Debugging
1. Override entrypoint:
   ```bash
   docker run -it --entrypoint /bin/sh image-name
   ```

2. Execute into running container:
   ```bash
   docker exec -it container-name /bin/sh
   ```

## 📞 Getting Help

### Before Asking for Help
1. Check this guide
2. Review error messages carefully
3. Search existing issues
4. Try basic troubleshooting steps

### When Asking for Help
Provide:
- Exact error message
- Steps to reproduce
- What you've tried
- Relevant logs
- Environment details

### Support Channels
- Slack: #bootcamp-devops-sre
- Email: bootcamp-support@semperti.com
- Office Hours: Tuesdays 2-4 PM

Remember: Every problem is a learning opportunity!