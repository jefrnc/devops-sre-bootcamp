# Contributing to the Bootcamp Repository

Welcome to the Semperti DevOps/SRE Bootcamp! This guide will help you understand how to contribute to this repository effectively.

## 🎯 Before You Start

1. **Read the README.md** - Understand the project structure and bootcamp objectives
2. **Check existing issues** - See if someone else is working on similar tasks
3. **Join Slack** - Connect with the team in #bootcamp-devops-sre channel

## 🌿 Branching Strategy

### Branch Naming Convention
```
task<number>-<descriptive-name>
```

Examples:
- `task1-terraform-vm`
- `task2-ansible-config`
- `task3-docker-setup`

### Branch Rules
- Always branch from `master`
- Keep branches focused on single tasks
- Delete branches after PR merge

## 📝 Commit Messages

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples
```
feat(terraform): add Azure VM configuration

- Configure CentOS 7 VM with 2 cores and 2GB RAM
- Set up networking with VPN access
- Add output variables for IP and SSH details

Task: #1
```

## 🔄 Pull Request Process

### Before Creating a PR

1. **Test Locally**
   ```bash
   # Run tests
   make test
   
   # Build application
   make build
   
   # Run Docker build
   make docker-build
   ```

2. **Update Documentation**
   - Add/update README in your branch
   - Document any new dependencies
   - Include screenshots if applicable

3. **Check Code Quality**
   - No hardcoded credentials
   - Follow existing code style
   - Remove debug/console logs

### PR Template

```markdown
## Description
Brief description of changes

## Task Reference
- Task Number: #X
- Zoho Sprint Link: [Link]

## Type of Change
- [ ] Infrastructure (Terraform/Ansible)
- [ ] Application Code
- [ ] CI/CD Pipeline
- [ ] Documentation
- [ ] Configuration

## Testing
- [ ] Local tests pass
- [ ] Docker build successful
- [ ] Manual testing completed

## Screenshots/Evidence
(Add relevant screenshots or command outputs)

## Checklist
- [ ] Code follows project standards
- [ ] Documentation updated
- [ ] No sensitive data exposed
- [ ] PR has descriptive title
```

### PR Guidelines

1. **Keep PRs Small** - One task per PR
2. **Only Modified Files** - Don't include unchanged files
3. **Descriptive Title** - Use format: `Task X: Brief description`
4. **Link Issues** - Reference task numbers
5. **Request Reviews** - Tag appropriate reviewers

## 🧪 Testing Guidelines

### Unit Tests
- Write tests for new functionality
- Maintain existing test coverage
- Use meaningful test names

### Integration Tests
- Test database connections
- Verify API endpoints
- Check authentication flows

### Manual Testing
- Test all user workflows
- Verify PDF upload/download
- Check different user roles

## 📁 File Organization

### Directory Structure
```
/
├── Code/               # Application source code
├── terraform/          # Infrastructure as Code
├── ansible/            # Configuration management
├── docker/             # Docker-related files
├── jenkins/            # CI/CD pipelines
├── docs/               # Additional documentation
└── scripts/            # Utility scripts
```

### File Naming
- Use lowercase with hyphens
- Be descriptive but concise
- Include version numbers where relevant

## 🔐 Security Guidelines

### Never Commit
- Passwords or API keys
- Private certificates
- Personal information
- Production data

### Use Instead
- Environment variables
- Ansible Vault for secrets
- Placeholder values in examples
- `.gitignore` for sensitive files

## 📚 Documentation Standards

### Code Comments
- Explain "why" not "what"
- Document complex logic
- Include examples for usage

### README Files
- Clear installation steps
- Prerequisites listed
- Common issues and solutions
- Contact information

### Screenshots
- Use meaningful filenames
- Annotate when necessary
- Compress large images
- Store in `docs/images/`

## 🚀 Deployment Notes

### Environments
- **Development**: Local machine
- **Staging**: Test environment
- **Production**: Live environment

### Deployment Checklist
1. All tests passing
2. Documentation updated
3. Secrets configured
4. Rollback plan ready
5. Team notified

## 🆘 Getting Help

### Resources
- Project README
- Team Slack channel
- Weekly office hours
- Existing PR examples

### Escalation Path
1. Check documentation
2. Ask in Slack
3. Contact task mentor
4. Schedule 1:1 session

## 🎉 Recognition

Great contributions include:
- Improving documentation
- Adding helpful scripts
- Sharing knowledge
- Helping teammates
- Finding and fixing bugs

Remember: The bootcamp is a learning experience. Don't hesitate to ask questions and learn from mistakes!

## 📜 License

By contributing, you agree that your contributions will be licensed under the same license as the project.