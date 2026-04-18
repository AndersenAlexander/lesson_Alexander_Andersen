# Homework for the topic “Studying Agro CD + CD”

## Task steps

1. Jenkins + Helm + Terraform

- Install Jenkins via Helm, automating the installation via Terraform.
- Ensure Jenkins is working via Kubernetes Agent (Kaniko + Git).
- Implement a pipeline (via Jenkinsfile) that:
- Builds an image from a Dockerfile;
- Pushes it to ECR;
- Updates a tag in values.yaml of another repository;
- Pushes changes to main.

2. Argo CD + Helm + Terraform

- Install Argo CD via Helm using Terraform.
- Configure the Argo CD Application that monitors the Helm chart update.
- Argo CD should automatically synchronize changes to the cluster after Git updates.

## Setting variables

Create a file `terraform.tfvars` with the following variables:

```
github_token = <your github token>
github_username = <your github username>
github_repo_url = "https://github.com/<repo>.git"
```

You can use `terraform.tfvars.example` as an example.

## Commands for initialization, startup, and removal

```bash
# Initialization
terraform init

# View infrastructure changes
terraform plan

# Apply infrastructure
terraform apply

# Remove infrastructure
terraform destroy
```

## kubectl configuration

```bash
# Connect to EKS cluster
aws eks update-kubeconfig --region us-west-2 --name [EKS_CLUSTER_NAME]

# Check access
kubectl get nodes
```

## Upload Docker image to newly created ECR repository

```bash
# Go to Django project folder
cd docker/django

# Build image without cache
docker build --no-cache -t django-app .

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin [ACCOUNT_ID].dkr.ecr.us-west-2.amazonaws.com

# Tagging
docker tag django-app:latest [ACCOUNT_ID].dkr.ecr.us-west-2.amazonaws.com/django-app:latest

# Push
docker push [ACCOUNT_ID].dkr.ecr.us-west-2.amazonaws.com/django-app:latest

# Return to project root
cd ../..
```

## Using Helm:

```bash
cd charts/django-app
helm install django-app .
```

where `django-app` is your helm chart name.

## Removing resources:

Kubernetes (PODs, Services, Deployments etc.)

```bash
helm uninstall django-app
```

where `django-app` is your helm chart name.

Terraform (EKS, VPC, ECR etc.)

```bash
terraform destroy
```

## Additional information:

If you want to upgrade your helm chart:

```bash
helm upgrade django-app .
```

If you want to upgrade terraform:

```bash
terraform init -upgrade
terraform plan
terraform apply
```

### Access Jenkins

```bash
# Jenkins URL
kubectl get services -n jenkins

# Get Jenkins initial password
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo

# Is the password already set: admin123
```

### Access Argo CD

```
# Get Argo CD URL
kubectl get services -n argocd

# Get admin initial password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

### Remote Backend Configuration

After initial deployment to enable remote backend:

1. Uncomment the backend configuration block in `backend.tf`.

2. Run `terraform init` with the parameter to reconnect the backend:

```bash
terraform init -reconfigure
```

### Recovery

1. Comment out the backend configuration in `backend.tf`.
2. Run `terraform init`.
3. Apply the configuration `terraform apply`.
4. Uncomment the backend and run `terraform init -reconfigure`.

---
