# Automated Infrastructure Validation Using Terraform and Docker

## Project Overview

**Selected Option: Option 4 — Automated Infrastructure Validation**

This project demonstrates Infrastructure as Code (IaC) using Terraform to deploy and manage a two-container Docker environment. An Nginx web server serves a custom HTML page while an Alpine Linux container performs automated HTTP validation.

## Industry Application

Automated infrastructure validation is used in DevOps and CI/CD pipelines to verify that deployed services are functioning correctly. This project demonstrates how automated testing can detect connectivity issues and incorrect application responses before further deployment.

## Infrastructure

- **Nginx (web):** Serves a custom HTML webpage.
- **Alpine Linux (test-client):** Performs HTTP connectivity tests.
- **Docker network (validation-network):** Enables container-to-container communication using container names.
- **Bind mount:** Mounts the local index.html file into the Nginx container as read-only.
- **test.sh:** Automatically validates HTTP connectivity and webpage content.

## Prerequisites

- Terraform
- Docker Desktop or Docker Engine
- Git
- Bash

## Deployment

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Enter `yes` when prompted.

## Verification

Verify the running containers and custom network:

```bash
docker ps
docker network inspect validation-network
```

Test container-to-container communication:

```bash
docker exec test-client wget -qO- http://web
```

Verify the bind mount:

```bash
docker inspect web --format '{{json .Mounts}}'
```

Run automated infrastructure validation:

```bash
chmod +x test.sh
./test.sh
echo "Exit code: $?"
```

The script returns exit code 0 when all tests pass and exit code 1 if a test fails.

## Terraform Lifecycle Verification

```bash
terraform plan
```

Expected result: No changes. Your infrastructure matches the configuration.

## Troubleshooting

During initial testing, Docker encountered an I/O error when accessing the bind-mounted HTML file from the macOS Desktop directory. Moving the project to a directory outside Desktop and recreating the Nginx container resolved the issue.

## Cleanup

```bash
terraform destroy
```

Enter `yes` when prompted to remove the provisioned infrastructure.