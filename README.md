
# Terraform Docker CI/CD Pipeline

![CI/CD Pipeline](https://github.com/jjjoannaa/terraform-docker-project/actions/workflows/cicd.yml/badge.svg)

## Project Overview

This project demonstrates an automated CI/CD pipeline integrating
GitHub, GitHub Actions, Terraform and Docker. It automatically builds,
deploys and verifies a custom Nginx web application whenever changes
are pushed to the main branch.

## Technologies

- Git and GitHub
- GitHub Actions
- Terraform
- Docker
- Nginx
- Alpine Linux
- Bash

## Infrastructure

- Custom Docker image: validation-web:1.0
- Nginx web container: web
- Alpine testing container: test-client
- Custom Docker network: validation-network

The application source code is packaged directly into the custom
Docker image. The Alpine container communicates with the Nginx
container through the shared Docker network.

## Automated CI/CD Workflow

The workflow runs on a GitHub-hosted Ubuntu runner using its local
Docker environment.

1. Checkout the repository.
2. Install Terraform.
3. Build the custom Docker image.
4. Initialize and validate Terraform.
5. Generate the Terraform deployment plan.
6. Apply the Terraform configuration.
7. Verify running containers.
8. Execute automated application tests.
9. Verify infrastructure consistency.
10. Destroy temporary infrastructure.

The workflow automatically runs on pushes to the main branch.
Manual execution is also supported through workflow_dispatch.

## Local Deployment

Prerequisites: Git, Terraform and a running Docker environment.

```bash
git clone https://github.com/jjjoannaa/terraform-docker-project.git
cd terraform-docker-project

docker build -t validation-web:1.0 .

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Application Verification

```bash
docker ps
docker exec test-client wget -qO- http://web
./test.sh
```

Expected results:

- Nginx is reachable from Alpine.
- Custom webpage content verified.
- ALL TESTS PASSED.

## Infrastructure Consistency

```bash
terraform plan
```

Expected result: No changes. Your infrastructure matches
the configuration.

## Cleanup

```bash
terraform destroy
```

GitHub Actions automatically destroys its temporary infrastructure
after verification.

## Industry Relevance

This project demonstrates DevOps practices including Infrastructure
as Code, automated application builds, continuous integration,
automated deployment and infrastructure validation.